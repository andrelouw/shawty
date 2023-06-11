import Artist
import ArtistIOS
import Core
import Networking
import Shared
import SharedIOS
import UIIOS
import UIKit

final class MainCoordinator: Coordinator {
  var navigationController: UINavigationController
  var childCoordinators = [Coordinator]()

  let baseURL = URL(string: "https://api.deezer.com")!
  lazy var httpClient: HTTPClient = URLSessionHTTPClient(session: .shared)
  lazy var imageLoader: any ImageDataLoader = RemoteImageDataLoader(client: httpClient)

  init(appWindow: UIWindow) {
    navigationController = UINavigationController()
    appWindow.rootViewController = navigationController
  }

  func start() {
    let coordinator = artistSearchCoordinator()
    addChild(coordinator)
    coordinator.delegate = WeakRefVirtualProxy(self)

    coordinator.start()
  }

  private func artistSearchCoordinator() -> ArtistSearchListCoordinator {
    makeArtistSearchListCoordinator(
      navigationController: navigationController,
      removeCoordinatorWith: removeChild
    )
  }
}

extension MainCoordinator: ArtistSearchFactory {
  func makeArtistSearchListCoordinator(
    navigationController: UINavigationController,
    removeCoordinatorWith _: (UIIOS.Coordinator?) -> Void
  ) -> ArtistIOS.ArtistSearchListCoordinator {
    ArtistSearchListCoordinator(
      navigationController: navigationController,
      artistSearchFactory: self,
      removeCoordinatorWith: removeChild
    )
  }

  func makeArtistSearchListViewController(
    onArtistSelection: @escaping (Int) -> Void
  ) -> ArtistSearchListViewController {
    ArtistSearchListUIComposer.listComposedWith(
      artistSearchLoader: makeArtistSearchLoader(),
      imageDataLoader: makeImageDataLoader(),
      selection: onArtistSelection
    )
  }

  private func makeArtistSearchLoader() -> any ArtistSearchLoader {
    RemoteArtistSearchLoader(
      url: ArtistEndpoint.search.url(baseURL: baseURL),
      client: httpClient
    )
  }

  private func makeImageDataLoader() -> any ImageDataLoader {
    ImageDataLoaderCacheDecorator(
      imageDataLoader: RemoteImageDataLoader(client: httpClient),
      cache: ImageDataCacheStore()
    )
  }
}

extension MainCoordinator: ArtistSearchCoordinatorDelegate {
  func didSelectArtist(withID id: Int) {
    let alert = UIAlertController(
      title: "Artist Selected",
      message: "Artist ID: \(id)",
      preferredStyle: .alert
    )

    alert.addAction(
      UIAlertAction(
        title: "OK",
        style: .default
      )
    )

    navigationController.present(alert, animated: true)
  }
}
