import SharedIOS
import SwiftUI

final class TrackListViewController: UIHostingController<TrackListView> {
  init(
    listViewModel: TrackListViewModel
  ) {
    super.init(
      rootView: TrackListView(
        viewModel: listViewModel,
        rowView: { model in
          TrackRowView(model: model)
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
