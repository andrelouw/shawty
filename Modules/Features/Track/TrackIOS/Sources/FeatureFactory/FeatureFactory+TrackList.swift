import Shared
import SharedIOS
import SwiftUI
import Track

extension FeatureFactory {
  func makeTrackListViewController(
    for url: URL,
    isFirstViewController _: Bool = false,
    screenTitle _: String? = TrackIOSStrings.trackListScreenTitle,
    sectionTitle _: String? = nil,
    onTrackSelection: @escaping (Int) -> Void
  ) -> UIViewController {
    let view = makeTrackListView(
      for: url,
      onTrackSelection: onTrackSelection
    )

    return TrackListViewController(
      trackListView: view
    )
  }

  public func makeTrackListView(
    for url: URL,
    isFirstViewController: Bool = false,
    screenTitle: String? = TrackIOSStrings.trackListScreenTitle,
    sectionTitle: String? = nil,
    onTrackSelection: @escaping (Int) -> Void
  ) -> ListView<TrackRowView<Int>> {
    let remoteTrackLoader = RemoteTracksLoader(
      url: url,
      client: httpClient
    )

    let tracksCellModelAdapter = TracksRowModelAdapter(
      tracksLoader: remoteTrackLoader
    )

    let contentStreamAdapter = ValueLoaderContentStreamAdapter(
      loader: tracksCellModelAdapter
    )

    let viewModel = ListViewModel(
      screenTitle: screenTitle,
      sectionTitle: sectionTitle,
      shouldCancelTasksOnDisappear: isFirstViewController,
      contentLoader: contentStreamAdapter.load,
      onItemSelection: onTrackSelection
    )

    return ListView(
      viewModel: viewModel,
      rowView: { model in
        TrackRowView(model: model)
      }
    )
  }
}
