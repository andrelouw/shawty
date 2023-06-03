import SharedIOS
import SwiftUI

final class AlbumListViewController: UIHostingController<AlbumListView> {
  init(
    listViewModel: AlbumListViewModel
  ) {
    super.init(
      rootView: AlbumListView(
        viewModel: listViewModel,
        rowView: { rowViewModel in
          ImageTitleRowView(viewModel: rowViewModel)
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
