import XCTest
@testable import Testing

final class MemoryLeaksHelperTests: XCTestCase {
  func test_memoryLeakMethod_assertsMemoryLeakFailure() {
    let controller = makeSUT(expectFailure: true)

    controller.memoryLeakMethod()
  }

  func test_noMemoryLeakMethod_assertsNoMemoryLeakFailure() {
    let controller = makeSUT(expectFailure: false)

    controller.noMemoryLeakMethod()
  }

  func test_asyncNoMemoryLeakMethod_assertsNoMemoryLeakFailure() async throws {
    let controller = makeSUT(expectFailure: false)

    try await controller.asyncNoMemoryLeak()
  }

  // TODO: Finish test below by getting example of async leak AND where it triggers failure
  func test_asyncMemoryLeakMethod_assertsMemoryLeakFailure() async throws { }

  // MARK: Helpers

  private func makeSUT(
    expectFailure: Bool,
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> MockController {
    let client = MockClient()
    let controller = MockController(client: client)

    trackForMemoryLeaks(client, expectFailure: expectFailure, file: file, line: line)
    trackForMemoryLeaks(controller, expectFailure: expectFailure, file: file, line: line)

    return controller
  }

  private final class MockClient {
    func request() async throws -> String {
      try await withCheckedThrowingContinuation { cont in
        Task {
          try await Task.sleep(for: .milliseconds(20))
          cont.resume(with: .success("Success"))
        }
      }
    }

    func request(completion: @escaping (Result<String, Error>) -> Void) {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        completion(.success("Success"))
      }
    }

    func check(completion: @escaping () -> Void) {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        completion()
      }
    }
  }

  private final class MockController {
    let client: MockClient
    var property: String?
    private var continuation: CheckedContinuation<String, Error>?

    init(client: MockClient) {
      self.client = client
    }

    func asyncNoMemoryLeak() async throws {
      let property = try await client.request()
      self.property = property
    }

    func memoryLeakMethod() {
      client.request { result in
        self.property = try? result.get()
      }
    }

    func noMemoryLeakMethod() {
      client.request { [weak self] result in
        self?.property = try? result.get()
      }
    }
  }
}
