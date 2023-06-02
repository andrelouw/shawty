import SwiftUI

public struct ArtistSearchView<ContentView: View>: View {
  @ObservedObject var viewModel: SearchViewModel

  private var contentView: () -> ContentView

  public init(
    viewModel: SearchViewModel,
    contentView: @escaping () -> ContentView
  ) {
    self.viewModel = viewModel
    self.contentView = contentView
  }

  public var body: some View {
    NavigationView {
      contentView()
        .searchable(
          text: $viewModel.searchText,
          placement: .navigationBarDrawer(displayMode: .always),
          prompt: viewModel.promptText
        )
    }
  }
}
