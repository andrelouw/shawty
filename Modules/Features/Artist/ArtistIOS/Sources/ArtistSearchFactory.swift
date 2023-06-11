import UIIOS
import UIKit

public protocol ArtistSearchCoordinatorFactory {
  func makeArtistSearchListCoordinator(
    navigationController: UINavigationController,
    viewControllerFactory: ArtistSearchViewControllerFactory,
    removeCoordinatorWith: @escaping (Coordinator?) -> Void
  ) -> ArtistSearchListCoordinator
}

extension ArtistSearchCoordinatorFactory {
  public func makeArtistSearchListCoordinator(
    navigationController: UINavigationController,
    viewControllerFactory: ArtistSearchViewControllerFactory,
    removeCoordinatorWith: @escaping (Coordinator?) -> Void
  ) -> ArtistSearchListCoordinator {
    ArtistSearchListCoordinator(
      navigationController: navigationController,
      viewControllerFactory: viewControllerFactory,
      removeCoordinatorWith: removeCoordinatorWith
    )
  }
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
    removeCoordinatorWith: @escaping (Coordinator?) -> Void
  ) -> ArtistSearchListCoordinator {
    makeArtistSearchListCoordinator(
      navigationController: navigationController,
      viewControllerFactory: self,
      removeCoordinatorWith: removeCoordinatorWith
    )
  }
}
