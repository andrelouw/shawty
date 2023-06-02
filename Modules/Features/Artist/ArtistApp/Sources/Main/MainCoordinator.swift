import Artist
import ArtistIOS
import Core
import Networking
import Shared
import SharedIOS
import UI
import UIKit

final class MainCoordinator: Coordinator, FeatureFactory {
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
    // TODO: WeakReference Proxy
    coordinator.delegate = self

    coordinator.start()
  }

  private func artistSearchCoordinator() -> ArtistSearchCoordinator {
    ArtistSearchCoordinator(
      navigationController: navigationController,
      featureFactory: self,
      removeCoordinatorWith: removeChild
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
