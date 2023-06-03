import Foundation
import Shared

/// Adapt `ValueLoader` output to provide `ContentViewStream` where the stream value is `Loader.Output`
public struct ValueLoaderContentStreamAdapter<Loader: ValueLoader> {
  public typealias EmptyEvaluation = (Loader.Output) -> Bool
  private let loader: Loader
  private let isEmptyEvaluation: EmptyEvaluation

  public init(
    loader: Loader,
    isEmptyEvaluation: @escaping EmptyEvaluation
  ) {
    self.loader = loader
    self.isEmptyEvaluation = isEmptyEvaluation
  }

  public func load() -> ContentViewStream<Loader.Output> {
    AsyncStream { continuation in
      Task {
        do {
          continuation.yield(.loading)
          let value = try await loader.load()

          guard !isEmpty(value) else {
            continuation.yield(.empty)
            continuation.finish()
            return
          }

          continuation.yield(.loaded(value))
        } catch {
          continuation.yield(.error(SharedIOSStrings.fullScreenConnectionError))
        }
        continuation.finish()
      }
    }
  }

  private func isEmpty(_ value: Loader.Output) -> Bool {
    isEmptyEvaluation(value)
  }
}

// MARK: - Convenience init

extension ValueLoaderContentStreamAdapter where Loader.Output: Collection {
  public init(loader: Loader) {
    self.init(
      loader: loader,
      isEmptyEvaluation: { $0.isEmpty }
    )
  }
}
