import SharedIOS
import SwiftUI

final class ArtistSearchListViewController: UIHostingController<ArtistSearchListView> {
  init(
    searchViewModel: SearchViewModel,
    listViewModel: ArtistSearchListViewModel
  ) {
    super.init(
      rootView: ArtistSearchListView(
        viewModel: searchViewModel,
        contentView: {
          ListView(
            viewModel: listViewModel
          ) { rowViewModel in
            ImageTitleRowView(viewModel: rowViewModel)
          }
        }
      )
    )
  }

  @available(*, unavailable)
  @MainActor
  required dynamic init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
