import SharedIOS
import SwiftUI
import TrackIOS
import TrackIOS

final class AlbumDetailViewController: UIViewController {
  private let albumViewModel: AlbumDetailViewModel
  private let listViewModel: TrackListViewModel

  init(
    albumViewModel: AlbumDetailViewModel,
    listViewModel: TrackListViewModel
  ) {
    self.albumViewModel = albumViewModel
    self.listViewModel = listViewModel
    super.init(nibName: nil, bundle: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    embed(albumDetailView())
  }

  private func albumDetailView() -> some View {
    NavigationView {
      AlbumDetailView(
        viewModel: albumViewModel
      ) { [unowned self] in
        ListView(
          viewModel: listViewModel,
          rowView: { model in
            TrackRowView(model: model)
          }
        )
      }
    }
  }

  @available(*, unavailable)
  @MainActor
  required dynamic init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
