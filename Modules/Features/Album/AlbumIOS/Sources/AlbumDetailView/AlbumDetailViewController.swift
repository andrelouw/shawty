import SharedIOS
import SwiftUI
import TrackIOS

final class AlbumDetailViewController: UIHostingController<AlbumDetailView<ListView<TrackRowView<Int>>>> {
  init(
    view: AlbumDetailView<ListView<TrackRowView<Int>>>
  ) {
    super.init(rootView: view)
  }

  @available(*, unavailable)
  @MainActor
  required dynamic init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
