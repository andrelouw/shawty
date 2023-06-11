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
      removeCoordinatorWith: removeChild(_:)
    )
  }
}

extension MainCoordinator: ArtistSearchFactory {
  func makeArtistSearchListViewController(
    onArtistSelection: @escaping (Int) -> Void
  ) -> UIViewController {
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
    RemoteImageDataLoader(client: httpClient)
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
