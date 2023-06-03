import Shared
import SharedIOS
import SwiftUI
import Track

extension FeatureFactory {
  /// Creates a `TrackListViewController` that loads `Tracks` from a given `URL`
  /// - Parameter onArtistSelection:  The action to take when an `Artist` is selected on the list view
  /// - Parameter url: The `URL` used to populate the view with tracks
  /// - Parameter sectionTitle: The section title for the list of tracks
  /// - Parameter onTrackSelection: The action to take when an `Track` is selected on the list view
  /// - Returns: A `TrackListViewController`
  func makeTrackListViewController(
    for url: URL,
    sectionTitle: String? = nil,
    onTrackSelection: @escaping (Int) -> Void
  ) -> UIViewController {
    let viewModel = makeTrackListViewModel(
      for: url,
      sectionTitle: sectionTitle,
      onTrackSelection: onTrackSelection
    )

    return TrackListViewController(
      screenTitle: TrackIOSStrings.trackListScreenTitle,
      listViewModel: viewModel
    )
  }

  ///  /// Creates a `TrackListViewModel` to drive a `TrackListView` in displaying `Track` items
  /// - Parameter url: The `URL` used to populate the view with tracks
  /// - Parameter sectionTitle: The section title for the list of tracks
  /// - Parameter onTrackSelection: The action to take when an `Track` is selected on the list view
  /// - Returns: A `TrackListViewModel`
  public func makeTrackListViewModel(
    for url: URL,
    sectionTitle: String? = nil,
    onTrackSelection: @escaping (Int) -> Void
  ) -> TrackListViewModel {
    // Loaders
    let remoteTrackLoader = RemoteTracksLoader(
      url: url,
      client: httpClient
    )

    // Adapters
    let tracksCellModelAdapter = TracksRowModelAdapter(
      tracksLoader: remoteTrackLoader
    )

    let contentStreamAdapter = ValueLoaderContentStreamAdapter(
      loader: tracksCellModelAdapter
    )

    return ListViewModel(
      sectionTitle: sectionTitle,
      contentLoader: contentStreamAdapter.load,
      onItemSelection: onTrackSelection
    )
  }
}
