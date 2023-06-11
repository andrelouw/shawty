import Album
import AlbumIOS
import Core
import Networking
import Shared
import UIIOS
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
    let coordinator = albumListCoordinator()
    addChild(coordinator)
    coordinator.delegate = WeakRefVirtualProxy(self)

    coordinator.start()
  }

  private func albumListCoordinator() -> AlbumListCoordinator {
    AlbumListCoordinator(
      albumListURL: baseURL.appending(path: "artist/4768753/albums"),
      navigationController: navigationController,
      featureFactory: self,
      removeCoordinatorWith: removeChild
    )
  }
}

extension MainCoordinator: AlbumListCoordinatorDelegate {
  public func didSelectTrack(withID id: Int) {
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
