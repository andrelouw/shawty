import Shared
import SharedIOS
import SwiftUI
import Track

extension FeatureFactory {
  func makeTrackListViewController(
    for url: URL,
    isFirstViewController: Bool = false,
    screenTitle: String? = TrackIOSStrings.trackListScreenTitle,
    sectionTitle: String? = nil,
    onTrackSelection: @escaping (Int) -> Void
  ) -> UIViewController {
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

    return TrackListViewController(
      listViewModel: viewModel
    )
  }
}
