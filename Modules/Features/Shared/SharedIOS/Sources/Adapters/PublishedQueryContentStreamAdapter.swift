import Combine
import Shared

public protocol QueryValidating {
  func isValid() -> Bool
}

/// Adapts a published query value to an Async stream of ContentViewState<Value> where Value is the given Loader's output
public final class PublishedQueryContentStreamAdapter<Loader: QueryValueLoader> where Loader.Input: QueryValidating {
  public typealias EmptyEvaluation = (Loader.Output) -> Bool
  private let loader: Loader
  private let isEmptyEvaluation: EmptyEvaluation
  private let queryPublisher: AnyPublisher<Loader.Input, Never>

  private var querySubscription: AnyCancellable?

  public init(
    queryPublisher: AnyPublisher<Loader.Input, Never>,
    loader: Loader,
    isEmpty isEmptyEvaluation: @escaping EmptyEvaluation
  ) {
    self.loader = loader
    self.isEmptyEvaluation = isEmptyEvaluation
    self.queryPublisher = queryPublisher
  }

  public func load() -> ContentViewStream<Loader.Output> {
    AsyncStream { [weak self] continuation in
      guard let self else { return continuation.finish() }
      querySubscription = queryPublisher
        .sink { [weak self] query in
          guard let self else { return }
          continuation.yield(.loading)
          let contentViewState = await load(query)
          continuation.yield(contentViewState)
        }

      continuation.onTermination = { [weak self] _ in
        guard let self else { return }
        querySubscription?.cancel()
        querySubscription = nil
      }
    }
  }

  private func load(_ query: Loader.Input) async -> ContentViewState<Loader.Output> {
    do {
      guard query.isValid() else {
        return .noSearch
      }

      let value = try await loader.load(query)
      guard !isEmpty(value) else {
        return .empty
      }

      return .loaded(value)
    } catch {
      return .error(SharedIOSStrings.fullScreenConnectionError)
    }
  }

  private func isEmpty(_ value: Loader.Output) -> Bool {
    isEmptyEvaluation(value)
  }
}

extension PublishedQueryContentStreamAdapter where Loader.Output: Collection {
  public convenience init(
    queryPublisher: AnyPublisher<Loader.Input, Never>,
    loader: Loader
  ) {
    self.init(
      queryPublisher: queryPublisher,
      loader: loader,
      isEmpty: { $0.isEmpty }
    )
  }
}
