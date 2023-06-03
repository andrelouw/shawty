import SharedIOS
import SwiftUI

final class AlbumListViewController: UIHostingController<NavigationView<AlbumListView>> {
  init(
    listViewModel: AlbumListViewModel
  ) {
    super.init(
      rootView:
      NavigationView {
        AlbumListView(
          viewModel: listViewModel
        ) { rowViewModel in
          ImageTitleRowView(viewModel: rowViewModel)
        }
      }
    )
  }

  @available(*, unavailable)
  @MainActor
  required dynamic init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
