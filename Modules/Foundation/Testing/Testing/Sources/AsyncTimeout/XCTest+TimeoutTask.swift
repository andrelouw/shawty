import XCTest

extension XCTest {
  public func timeoutTask<Value>(
    timeout seconds: TimeInterval = 2,
    task: @escaping TimeoutTask<Value>.Operation
  ) async throws -> Value {
    try await TimeoutTask(seconds: seconds) {
      try await task()
    }.run()
  }
}
