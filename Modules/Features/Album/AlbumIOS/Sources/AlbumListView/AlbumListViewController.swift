import SharedIOS
import SwiftUI

final class AlbumListViewController: UIViewController {
  private let screenTitle: String
  private let listViewModel: AlbumListViewModel

  init(
    screenTitle: String,
    listViewModel: AlbumListViewModel
  ) {
    self.screenTitle = screenTitle
    self.listViewModel = listViewModel
    super.init(nibName: nil, bundle: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    embed(albumListView())
  }

  private func albumListView() -> some View {
    NavigationView {
      AlbumListView(
        viewModel: listViewModel
      ) { rowViewModel in
        ImageTitleRowView(viewModel: rowViewModel)
      }
      .navigationTitle(screenTitle)
      .navigationBarTitleDisplayMode(.automatic)
    }
  }

  @available(*, unavailable)
  @MainActor
  required dynamic init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
