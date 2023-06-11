import Album
import AlbumIOS
import Artist
import SwiftUI
import UIKit

extension LiveFeatureFactory: AlbumFactory {
  func makeAlbumListViewController(
    for albumID: Int,
    onAlbumSelection: @escaping (Int) -> Void
  ) -> UIViewController {
    AlbumListUIComposer.listComposedWith(
      albumsLoader: makeRemoteAlbumsLoader(for: albumID),
      imageDataLoader: imageLoader,
      selection: onAlbumSelection
    )
  }

  func makeAlbumDetailViewController(
    for albumID: Int,
    onTrackSelection _: @escaping (Int) -> Void
  ) -> UIViewController {
    AlbumDetailUIComposer.detailComposedWith(
      albumLoader: makeRemoteAlbumLoader(for: albumID),
      imageDataLoader: imageLoader,
      listView: { EmptyView() }
    )
  }

  private func makeRemoteAlbumsLoader(for albumID: Int) -> any AlbumsLoader {
    RemoteAlbumsLoader(
      url: ArtistEndpoint.albums(id: albumID).url(baseURL: baseURL),
      client: httpClient
    )
  }

  private func makeRemoteAlbumLoader(for albumID: Int) -> any AlbumLoader {
    RemoteAlbumLoader(
      url: AlbumEndpoint.album(id: albumID).url(baseURL: baseURL),
      client: httpClient
    )
  }
}
