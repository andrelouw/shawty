import AlbumIOS
import ArtistIOS
import Shared
import UI
import UIKit

final class ArtistSearchSceneCoordinator: Coordinator {
  public var childCoordinators = [Coordinator]()
  public let navigationController: UINavigationController
  private lazy var featureFactory: FeatureFactory = .live

  public init(
    with navigationController: UINavigationController
  ) {
    self.navigationController = navigationController
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
      featureFactory: featureFactory,
      removeCoordinatorWith: removeChild
    )
  }
}

extension ArtistSearchSceneCoordinator: ArtistSearchCoordinatorDelegate {
  public func didSelectArtist(withID id: Int) {
    let coordinator = AlbumListCoordinator(
      albumListURL: featureFactory.artistAlbumsURL(forArtistID: id),
      navigationController: navigationController,
      featureFactory: featureFactory,
      removeCoordinatorWith: removeChild
    )

    addChild(coordinator)

    // TODO: WeakReference Proxy
    coordinator.delegate = self
    coordinator.start()
  }
}

extension ArtistSearchSceneCoordinator: AlbumListCoordinatorDelegate {
  func didSelectTrack(withID id: Int) {
    let alert = UIAlertController(
      title: "'Playing' Track",
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
