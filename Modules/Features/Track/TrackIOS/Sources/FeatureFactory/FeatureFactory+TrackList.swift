import Shared
import SharedIOS
import SwiftUI
import Track

extension FeatureFactory {
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

  public func makeTrackListView(
    for url: URL,
    sectionTitle: String? = nil,
    onTrackSelection: @escaping (Int) -> Void
  ) -> ListView<TrackRowView<Int>> {
    let viewModel = makeTrackListViewModel(
      for: url,
      sectionTitle: sectionTitle,
      onTrackSelection: onTrackSelection
    )

    return ListView(
      viewModel: viewModel,
      rowView: { model in
        TrackRowView(model: model)
      }
    )
  }

  private func makeTrackListViewModel(
    for url: URL,
    sectionTitle: String? = nil,
    onTrackSelection: @escaping (Int) -> Void
  ) -> TrackListViewModel {
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

    return ListViewModel(
      sectionTitle: sectionTitle,
      contentLoader: contentStreamAdapter.load,
      onItemSelection: onTrackSelection
    )
  }
}
