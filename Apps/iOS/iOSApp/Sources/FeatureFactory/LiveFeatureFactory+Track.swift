import Album
import SwiftUI
import Track
import TrackIOS

extension LiveFeatureFactory: TrackViewFactory {
  func makeTrackListView(
    for albumID: Int,
    onTrackSelection: @escaping (Int) -> Void
  ) -> some View {
    TrackListUIComposer.listComposedWith(
      tracksLoader: makeRemoteTracksLoader(for: albumID),
      selection: onTrackSelection
    )
  }

  private func makeRemoteTracksLoader(
    for albumID: Int
  ) -> any TracksLoader {
    RemoteTracksLoader(
      url: AlbumEndpoint.tracks(id: albumID).url(baseURL: baseURL),
      client: httpClient
    )
  }
}
