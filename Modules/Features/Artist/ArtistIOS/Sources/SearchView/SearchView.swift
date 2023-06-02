import SwiftUI

// TODO: Can move this to Shared Module, since it is not coupled to the artist domain
public struct SearchView<ContentView: View>: View {
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
