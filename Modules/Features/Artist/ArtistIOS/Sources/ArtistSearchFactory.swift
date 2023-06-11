import UIIOS
import UIKit

public protocol ArtistSearchCoordinatorFactory {
  func makeArtistSearchListCoordinator(
    navigationController: UINavigationController,
    viewControllerFactory: ArtistSearchViewControllerFactory,
    removeCoordinatorWith: (Coordinator?) -> Void
  ) -> ArtistSearchListCoordinator
}

public protocol ArtistSearchViewControllerFactory {
  func makeArtistSearchListViewController(
    onArtistSelection: @escaping (Int) -> Void
  ) -> ArtistSearchListViewController
}

public protocol ArtistSearchFactory: ArtistSearchCoordinatorFactory, ArtistSearchViewControllerFactory { }

extension ArtistSearchFactory {
  public func makeArtistSearchListCoordinator(
    navigationController: UINavigationController,
    removeCoordinatorWith: (Coordinator?) -> Void
  ) -> ArtistSearchListCoordinator {
    makeArtistSearchListCoordinator(
      navigationController: navigationController,
      viewControllerFactory: self,
      removeCoordinatorWith: removeCoordinatorWith
    )
  }
}
