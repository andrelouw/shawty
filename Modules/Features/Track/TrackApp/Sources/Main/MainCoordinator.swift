import Core
import Networking
import Shared
import SharedIOS
import Track
import TrackIOS
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
    let coordinator = trackListCoordinator()
    addChild(coordinator)
    // TODO: WeakReference Proxy
    coordinator.delegate = self

    coordinator.start()
  }

  private func trackListCoordinator() -> TrackListCoordinator {
    TrackListCoordinator(
      trackListURL: baseURL.appending(path: "album/373401057/tracks"),
      navigationController: navigationController,
      featureFactory: self,
      removeCoordinatorWith: removeChild
    )
  }
}

extension MainCoordinator: TrackListCoordinatorDelegate {
  func didSelectTrack(withID id: Int) {
    let alert = UIAlertController(
      title: "Track Selected",
      message: "Track ID: \(id)",
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
