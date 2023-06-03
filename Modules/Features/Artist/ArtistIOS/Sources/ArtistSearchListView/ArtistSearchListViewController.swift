import SharedIOS
import SwiftUI
import UI

final class ArtistSearchListViewController: UIViewController {
  private let screenTitle: String
  private let searchViewModel: SearchViewModel
  private let listViewModel: ArtistSearchListViewModel

  init(
    screenTitle: String,
    searchViewModel: SearchViewModel,
    listViewModel: ArtistSearchListViewModel
  ) {
    self.screenTitle = screenTitle
    self.searchViewModel = searchViewModel
    self.listViewModel = listViewModel
    super.init(nibName: nil, bundle: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    embed(artistSearchListView())
  }

  private func artistSearchListView() -> some View {
    NavigationView {
      ArtistSearchListView(
        viewModel: searchViewModel,
        contentView: { [unowned listViewModel] in // TODO: Check if this is not causing issues
          ListView(
            viewModel: listViewModel
          ) { rowViewModel in
            ImageTitleRowView(viewModel: rowViewModel)
          }
        }
      )
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
