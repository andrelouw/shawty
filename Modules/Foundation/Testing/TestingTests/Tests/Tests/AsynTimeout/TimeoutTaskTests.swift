import Testing
import XCTest

final class TimeoutTaskTests: XCTestCase {
  func test_run_doesNotThrowError_whenOperationDoesNotTimeOut() async throws {
    do {
      try await TimeoutTask(seconds: 2) { [weak self] in
        try await self?.operation(withDelayInSeconds: 0.02)
      }.run()
    } catch is TimeoutError {
      XCTFail("Expected operation to succeed and not time out")
    }
  }

  func test_run_throwsTimeoutError_whenOperationTimesOut() async throws {
    do {
      try await TimeoutTask(seconds: 0.02) { [weak self] in
        try await self?.operation(withDelayInSeconds: 1)
      }.run()
      XCTFail("Expected operation to fail with TimeoutError")
    } catch is TimeoutError {
      return
    }
  }

  func test_run_returnsResult_whenOperationDoesNotTimeOut() async throws {
    let expectedValue = "Some value"
    do {
      let value = try await TimeoutTask(seconds: 2) { [weak self] in
        await self?.operation(returning: expectedValue)
      }.run()

      XCTAssertEqual(expectedValue, value)
    } catch is TimeoutError {
      XCTFail("Expected operation to succeed and not time out")
    }
  }

  func test_run_throwsError_whenOperationThrowsError() async throws {
    do {
      let value = try await TimeoutTask(seconds: 2) { [weak self] in
        try await self?.operation(failingWithError: TimeoutTestError())
      }.run()

      XCTFail("Expected operation to fail with TimeoutTestError")
    } catch is TimeoutError {
      XCTFail("Expected operation to succeed and not time out")
    } catch is TimeoutTestError {
      return
    } catch {
      XCTFail("Expected TimeoutTestError and not \(error)")
    }
  }

  struct TimeoutTestError: Error { }

  private func operation(returning value: String) async -> String {
    value
  }

  private func operation(failingWithError error: Error) async throws -> String {
    throw error
  }

  private func operation(withDelayInSeconds seconds: TimeInterval) async throws {
    try await Task.sleep(for: .seconds(seconds))
  }
}
