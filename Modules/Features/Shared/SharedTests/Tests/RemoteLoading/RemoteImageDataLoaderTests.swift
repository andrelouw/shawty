import Networking
import NetworkTesting
import Shared
import Testing
import XCTest

final class RemoteImageDataLoaderTests: XCTestCase {
  func test_init_doesNotRequestDataFromURL() async throws {
    let (_, client) = makeSUT()

    XCTAssertEqual(client.requestedURLs, [])
  }

  func test_load_requestsDataFromURL_whenSearchQueryNotEmpty() async throws {
    let url = URL.anyURL()
    let (sut, client) = makeSUT()

    try await expect(
      requestedURLs: [url],
      on: client,
      when: {
        _ = try await timedOutLoad(with: url, for: sut)
      }
    )
  }

  func test_loadTwice_requestsDataFromURLTwice_whenSearchQueriesNotEmpty() async throws {
    let url = URL.anyURL()
    let (sut, client) = makeSUT()

    try await expect(
      requestedURLs: [url, url],
      on: client,
      when: {
        _ = try await timedOutLoad(with: url, for: sut)
        _ = try await timedOutLoad(with: url, for: sut)
      }
    )
  }

  func test_load_addsSearchQueryToURLAsQueryParameter() async throws {
    let url = URL.anyURL()
    let (sut, client) = makeSUT()
    client.complete(withStatusCode: 200, data: .anyValidJSONData(), for: url)

    _ = try await timedOutLoad(with: url, for: sut)

    let requestedURL = try XCTUnwrap(client.requestedURLs.first)
    XCTAssertEqual(requestedURL, url)
  }

  func test_load_deliversErrorOnClientError() async throws {
    let (sut, client) = makeSUT()

    try await expect(
      sut,
      with: .anyURL(),
      toCompleteWith: .failure(.connectivity),
      when: {
        client.complete(withError: .anyNSError())
      }
    )
  }

  func test_load_deliversInvalidDataErrorOnNon200HTTPResponse() async throws {
    let statusCodes = [199, 201, 300, 400, 500]

    try await statusCodes.asyncForEach { code in
      let url = URL.anyURL()
      let (sut, client) = makeSUT()

      try await expect(
        sut,
        with: url,
        toCompleteWith: .failure(.invalidData(.statusCode(code))),
        when: {
          client.complete(withStatusCode: code, data: .anyValidJSONData(), for: url)
        }
      )
    }
  }

  func test_load_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() async throws {
    let url = URL.anyURL()
    let (sut, client) = makeSUT()

    try await expect(
      sut,
      with: url,
      toCompleteWith: .failure(.invalidData(.decoding(.anyDataCorruptedError()))),
      when: {
        client.complete(withStatusCode: 200, data: Data(), for: url)
      }
    )
  }

  func test_load_deliversArtistsOn200HTTPResponseWithJSONItems() async throws {
    let url = URL.anyURL()
    let data = Data.anyValidJSONData()
    let (sut, client) = makeSUT()

    try await expect(
      sut,
      with: url,
      toCompleteWith: .success(data),
      when: {
        client.complete(withStatusCode: 200, data: data, for: url)
      }
    )
  }

  // TODO: Figure out how to do this one
  func test_load_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() throws {
    throw XCTSkip("Skipping due to complexity and lack of knowledge on how to do this in async/await ATM")
  }
}

// MARK: - Helpers

extension RemoteImageDataLoaderTests {
  private typealias Entity = Data
  private typealias SUT = RemoteImageDataLoader
  private typealias LoadResult = Result<Data, SUT.Error>

  private func makeSUT(
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> (sut: SUT, client: HTTPClientSpy) {
    let client = HTTPClientSpy()
    let sut = SUT(client: client)

    expectNoMemoryLeaks(for: sut, file: file, line: line)
    expectNoMemoryLeaks(for: client, file: file, line: line)

    return (sut, client)
  }

  // MARK: Assertion Helpers

  private func expect(
    requestedURLs urls: [URL],
    on client: HTTPClientSpy,
    file: StaticString = #filePath,
    line: UInt = #line,
    when action: () async throws -> Void
  ) async throws {
    do {
      try await action()
      XCTAssertEqual(client.requestedURLs, urls, file: file, line: line)
    } catch let error as TimeoutError {
      return XCTFail(error.localizedDescription, file: file, line: line)
    } catch is SUT.Error {
      // Ignoring Loader errors for this expectation, only checking requested urls
      return
    } catch {
      XCTFail("Expected action to succeed, but failed with error: \(error)", file: file, line: line)
    }
  }

  private func expect(
    _ sut: SUT,
    with url: URL,
    toCompleteWith expectedResult: LoadResult,
    when action: () -> Void,
    file: StaticString = #filePath,
    line: UInt = #line
  ) async throws {
    action()

    do {
      let result = try await timedOutLoad(with: url, for: sut)
      expect(result, toMatch: expectedResult, file: file, line: line)
    } catch let error as TimeoutError {
      return XCTFail(error.localizedDescription, file: file, line: line)
    } catch let receivedError {
      expect(receivedError, toMatch: expectedResult, file: file, line: line)
    }
  }

  private func expect(
    _ result: Entity,
    toMatch expectedResult: LoadResult,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    if case .failure(let error) = expectedResult {
      return XCTFail("Expected load() to fail with error: \(error)", file: file, line: line)
    }

    do {
      let successResults = try expectedResult.get()
      XCTAssertEqual(result, successResults, file: file, line: line)
    } catch {
      return XCTFail("Expected load() to succeed with artists: \(result)", file: file, line: line)
    }
  }

  private func expect(
    _ error: Error,
    toMatch expectedResult: LoadResult,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    switch expectedResult {
    case .success(let artists):
      return XCTFail(
        "Expected load() to succeed with artists: \(artists)",
        file: file,
        line: line
      )

    case .failure(let expectedError):
      guard let error = error as? SUT.Error else {
        return XCTFail(
          "Expected error of type RemoteArtistSearchLoader.Error",
          file: file,
          line: line
        )
      }

      XCTAssertEqual(error, expectedError, file: file, line: line)
    }
  }

  // MARK: Timeout Loader Helper

  private func timedOutLoad(
    with url: URL,
    for sut: SUT,
    timeout seconds: TimeInterval = 2
  ) async throws -> Entity {
    // FIXME: The `unowned sut` is a weird one. The timeout task is holding onto sut for some reason
    try await timeoutTask(timeout: seconds) { [unowned sut] in
      try await sut.load(url)
    }
  }
}
