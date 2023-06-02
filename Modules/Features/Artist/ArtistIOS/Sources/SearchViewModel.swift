import Combine
import SwiftUI

public final class SearchViewModel: ObservableObject {
  @MainActor
  @Published var searchText = ""

  @MainActor
  var promptText: String = ArtistIOSStrings.artistSearchPrompt

  public func searchTextPublisher() -> AnyPublisher<String, Never> {
    searchTextCurrentValueSubject.eraseToAnyPublisher()
  }

  private var searchTextCurrentValueSubject = CurrentValueSubject<String, Never>("")

  private var subscription: AnyCancellable?

  init() {
    subscription = $searchText.sink { [weak self] in
      guard let self else { return }
      searchTextCurrentValueSubject.send($0)
    }
  }
}
