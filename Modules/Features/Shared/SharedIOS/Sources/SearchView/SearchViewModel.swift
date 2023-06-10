import Combine
import Core
import SwiftUI

public final class SearchViewModel: ObservableObject, MainQueueUpdating {
  @MainActor
  @Published var searchText = ""

  let promptText: String

  private var searchTextCurrentValueSubject = CurrentValueSubject<String, Never>("")
  private var subscription: AnyCancellable?

  public init(
    promptText: String
  ) {
    self.promptText = promptText

    subscription = $searchText.sink { [weak self] in
      guard let self else { return }
      searchTextCurrentValueSubject.send($0)
    }
  }

  public func searchTextPublisher() -> AnyPublisher<String, Never> {
    searchTextCurrentValueSubject.eraseToAnyPublisher()
  }
}
