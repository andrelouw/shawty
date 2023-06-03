import Combine
import Shared

/// Adapts a published query value to an `AsyncStream` of `ContentViewState<Value>` where Value is the given `Loader`'s `Output`
public final class PublishedQueryContentStreamAdapter<Loader: QueryValueLoader> {
  public typealias EmptyQueryEvaluation = (Loader.Input) -> Bool
  public typealias EmptyOutputEvaluation = (Loader.Output) -> Bool

  private let loader: Loader
  private let isEmptyQuery: EmptyQueryEvaluation
  private let isEmptyOutput: EmptyOutputEvaluation
  private let queryPublisher: AnyPublisher<Loader.Input, Never>

  private var querySubscription: AnyCancellable?

  public init(
    queryPublisher: AnyPublisher<Loader.Input, Never>,
    loader: Loader,
    isEmptyQuery: @escaping EmptyQueryEvaluation,
    isEmptyOutput: @escaping EmptyOutputEvaluation
  ) {
    self.loader = loader
    self.isEmptyQuery = isEmptyQuery
    self.isEmptyOutput = isEmptyOutput
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
      guard isEmptyQuery(query) else {
        return .noSearch
      }

      let value = try await loader.load(query)
      guard !isEmptyOutput(value) else {
        return .empty
      }

      return .loaded(value)
    } catch {
      return .error(SharedIOSStrings.fullScreenConnectionError)
    }
  }
}

// MARK: - Convenience init

extension PublishedQueryContentStreamAdapter where Loader.Output: Collection, Loader.Input == String {
  public convenience init(
    queryPublisher: AnyPublisher<Loader.Input, Never>,
    loader: Loader
  ) {
    self.init(
      queryPublisher: queryPublisher,
      loader: loader,
      isEmptyQuery: { $0.isEmpty },
      isEmptyOutput: { $0.isEmpty }
    )
  }
}
