import Foundation

// Reference: Book - Modern Concurrency in Swift by Martin Todorov
public class TimeoutTask<Success> {
  public typealias Operation = @Sendable () async throws -> Success
  let nanoseconds: UInt64
  let operation: Operation

  private var continuation: CheckedContinuation<Success, Error>?

  private var timerTask: Task<(), Error>?
  private var operationTask: Task<(), Never>?

  public init(
    seconds: TimeInterval,
    operation: @escaping @Sendable () async throws -> Success
  ) {
    nanoseconds = UInt64(seconds * 1_000_000_000)
    self.operation = operation
  }

  public func run() async throws -> Success {
    try await withCheckedThrowingContinuation { continuation in
      self.continuation = continuation

      timerTask = Task {
        try await Task.sleep(nanoseconds: nanoseconds)
        operationTask?.cancel()
        self.continuation?.resume(throwing: TimeoutError())
        self.continuation = nil
      }

      operationTask = Task {
        do {
          let result = try await operation()
          timerTask?.cancel()
          self.continuation?.resume(returning: result)
          self.continuation = nil
        } catch {
          self.continuation?.resume(throwing: error)
        }
      }
    }
  }

  public func cancel() {
    continuation?.resume(throwing: CancellationError())
    continuation = nil
    timerTask?.cancel()
    operationTask?.cancel()
  }
}
