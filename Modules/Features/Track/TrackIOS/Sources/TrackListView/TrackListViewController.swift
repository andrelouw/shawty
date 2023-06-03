import SharedIOS
import SwiftUI

final class TrackListViewController: UIHostingController<TrackListView> {
  init(
    trackListView: TrackListView
  ) {
    super.init(
      rootView: trackListView
    )
  }

  @available(*, unavailable)
  @MainActor
  required dynamic init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
