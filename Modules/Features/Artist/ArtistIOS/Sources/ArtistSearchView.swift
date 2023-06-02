import SwiftUI

public struct ArtistSearchView<ContentView: View>: View {
  @State private var searchText: String

  private var promptText: String
  private var contentView: () -> ContentView

  public init(
    searchText: String,
    promptText: String,
    contentView: @escaping () -> ContentView
  ) {
    self.searchText = searchText
    self.promptText = promptText
    self.contentView = contentView
  }

  public var body: some View {
    NavigationView {
      contentView()
        .searchable(
          text: $searchText,
          placement: .navigationBarDrawer(displayMode: .always),
          prompt: promptText
        )
    }
  }
}
