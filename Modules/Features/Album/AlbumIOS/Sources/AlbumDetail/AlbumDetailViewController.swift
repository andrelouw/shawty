import SharedIOS
import SwiftUI
import TrackIOS
import TrackIOS

final class AlbumDetailViewController<ListView: View>: UIViewController {
  private let albumViewModel: AlbumDetailViewModel
  private let listView: () -> ListView

  init(
    albumViewModel: AlbumDetailViewModel,
    listView: @escaping () -> ListView
  ) {
    self.albumViewModel = albumViewModel
    self.listView = listView
    super.init(nibName: nil, bundle: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    embed(albumDetailView())
  }

  @available(*, unavailable)
  @MainActor
  required dynamic init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Album Detail View

extension AlbumDetailViewController {
  private func albumDetailView() -> some View {
    NavigationView {
      AlbumDetailView(
        viewModel: albumViewModel,
        contentView: listView
      )
    }
  }
}
