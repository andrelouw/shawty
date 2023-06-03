import SharedIOS
import SwiftUI

final class TrackListViewController: UIViewController {
  private let screenTitle: String
  private let listViewModel: TrackListViewModel

  init(
    screenTitle: String,
    listViewModel: TrackListViewModel
  ) {
    self.screenTitle = screenTitle
    self.listViewModel = listViewModel
    super.init(nibName: nil, bundle: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    embed(trackListView())
  }

  @available(*, unavailable)
  @MainActor
  required dynamic init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Track List View

extension TrackListViewController {
  private func trackListView() -> some View {
    NavigationView {
      TrackListView(
        viewModel: listViewModel
      ) { rowModel in
        TrackRowView(model: rowModel)
      }
      .navigationTitle(screenTitle)
      .navigationBarTitleDisplayMode(.automatic)
    }
  }
}
