import Combine
import Core
import SwiftUI

// TODO: Can move this to Shared Module, since it is not coupled to the artist domain
public final class SearchViewModel: ObservableObject, MainQueueUpdating {
  @MainActor
  @Published var searchText = ""

  @MainActor
  var promptText = ""

  private var searchTextCurrentValueSubject = CurrentValueSubject<String, Never>("")
  private var subscription: AnyCancellable?

  public init(
    promptText: String
  ) {
    mainQueueUpdate(\.promptText, with: promptText)

    subscription = $searchText.sink { [weak self] in
      guard let self else { return }
      searchTextCurrentValueSubject.send($0)
    }
  }

  public func searchTextPublisher() -> AnyPublisher<String, Never> {
    searchTextCurrentValueSubject.eraseToAnyPublisher()
  }
}
