import Album
import AlbumIOS
import Core
import Networking
import Shared
import UIIOS
import UIKit

public final class MainCoordinator: Coordinator {
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
    makeAlbumListCoordinator(
      for: 4768753,
      navigationController: navigationController,
      removeCoordinatorWith: removeChild(_:)
    )
  }
}

extension MainCoordinator: AlbumFactory {
  public func makeAlbumListViewController(
    for albumID: Int,
    onAlbumSelection: @escaping (Int) -> Void
  ) -> UIViewController {
    AlbumListUIComposer.listComposedWith(
      albumsLoader: makeRemoteAlbumsLoader(for: albumID),
      imageDataLoader: makeImageDataLoader(),
      selection: onAlbumSelection
    )
  }

  public func makeAlbumDetailViewController(
    for _: Int,
    onTrackSelection _: @escaping (Int) -> Void
  ) -> UIViewController {
    .init()
  }

  private func makeRemoteAlbumsLoader(for albumID: Int) -> any AlbumsLoader {
    let url = baseURL.appending(path: "artist/\(albumID)/albums")

    return RemoteAlbumsLoader(
      url: url,
      client: httpClient
    )
  }

  private func makeImageDataLoader() -> any ImageDataLoader {
    RemoteImageDataLoader(client: httpClient)
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
