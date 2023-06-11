import Artist
import ArtistIOS
import UIIOS
import UIKit

extension LiveFeatureFactory: ArtistSearchFactory {
  func makeArtistSearchListViewController(
    onArtistSelection: @escaping (Int) -> Void
  ) -> ArtistSearchListViewController {
    ArtistSearchListUIComposer.listComposedWith(
      artistSearchLoader: makeArtistSearchLoader(),
      imageDataLoader: imageLoader,
      selection: onArtistSelection
    )
  }

  private func makeArtistSearchLoader() -> any ArtistSearchLoader {
    RemoteArtistSearchLoader(
      url: ArtistEndpoint.search.url(baseURL: baseURL),
      client: httpClient
    )
  }
}
