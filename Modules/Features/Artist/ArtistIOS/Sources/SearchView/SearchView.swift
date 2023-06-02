import SwiftUI

// TODO: Can move this to Shared Module, since it is not coupled to the artist domain
struct SearchView<ContentView: View>: View {
  @ObservedObject var viewModel: SearchViewModel

  private var contentView: () -> ContentView

  init(
    viewModel: SearchViewModel,
    contentView: @escaping () -> ContentView
  ) {
    self.viewModel = viewModel
    self.contentView = contentView
  }

  var body: some View {
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
