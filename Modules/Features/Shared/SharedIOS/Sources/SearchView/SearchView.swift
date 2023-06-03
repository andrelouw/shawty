import SwiftUI

public struct SearchView<ContentView: View>: View {
  @ObservedObject private var viewModel: SearchViewModel

  private var contentView: () -> ContentView

  public init(
    viewModel: SearchViewModel,
    contentView: @escaping () -> ContentView
  ) {
    self.viewModel = viewModel
    self.contentView = contentView
  }

  public var body: some View {
    ZStack {
      contentView()
        .searchable(
          text: $viewModel.searchText,
          placement: .navigationBarDrawer(displayMode: .always),
          prompt: viewModel.promptText
        )
    }
  }
}
