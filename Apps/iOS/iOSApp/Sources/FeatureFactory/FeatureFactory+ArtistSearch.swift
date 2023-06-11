import Artist
import ArtistIOS
import UIIOS
import UIKit

extension FeatureFactory: ArtistSearchFactory {
  func makeArtistSearchListViewController(
    onArtistSelection: @escaping (Int) -> Void
  ) -> UIViewController {
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
