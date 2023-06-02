import Artist
import ArtistIOS
import Core
import Networking
import Shared
import SharedIOS
import UI
import UIKit

public final class MainCoordinator: Coordinator, FeatureFactory {
  public var navigationController: UINavigationController
  public var childCoordinators = [Coordinator]()

  public let baseURL = URL(string: "https://api.deezer.com")!
  public lazy var httpClient: HTTPClient = URLSessionHTTPClient(session: .shared)
  public lazy var imageLoader: any ImageDataLoader = RemoteImageDataLoader(client: httpClient)

  public init(appWindow: UIWindow) {
    navigationController = UINavigationController()
    appWindow.rootViewController = navigationController
  }

  public func start() {
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
  public func didSelectArtist(withID id: Int) {
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
