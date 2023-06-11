import Album
import AlbumIOS
import Artist
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
    for _: Int,
    onTrackSelection _: @escaping (Int) -> Void
  ) -> UIViewController {
    .init()
  }

  private func makeRemoteAlbumsLoader(for albumID: Int) -> any AlbumsLoader {
    RemoteAlbumsLoader(
      url: ArtistEndpoint.albums(id: albumID).url(baseURL: baseURL),
      client: httpClient
    )
  }
}
