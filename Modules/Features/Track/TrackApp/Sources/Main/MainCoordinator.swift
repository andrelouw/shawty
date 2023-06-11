import Core
import Networking
import Shared
import SharedIOS
import Track
import TrackIOS
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
    let coordinator = trackListCoordinator()
    addChild(coordinator)
    coordinator.delegate = WeakRefVirtualProxy(self)

    coordinator.start()
  }

  private func trackListCoordinator() -> TrackListCoordinator {
    makeTrackListCoordinator(
      for: 373401057,
      navigationController: navigationController,
      removeCoordinatorWith: removeChild(_:)
    )
  }
}

extension MainCoordinator: TrackFactory {
  func makeTrackListViewController(
    for albumID: Int,
    onTrackSelection: @escaping (Int) -> Void
  ) -> UIViewController {
    TrackListUIComposer.listComposedWith(
      tracksLoader: makeRemoteTracksLoader(for: albumID),
      selection: onTrackSelection
    )
  }

  private func makeRemoteTracksLoader(
    for albumID: Int
  ) -> any TracksLoader {
    RemoteTracksLoader(
      url: baseURL.appending(path: "album/\(albumID)/tracks"),
      client: httpClient
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
