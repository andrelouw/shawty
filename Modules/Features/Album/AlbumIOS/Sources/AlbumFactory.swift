import UIIOS
import UIKit

public protocol AlbumFactory: AlbumCoordinatorFactory, AlbumViewControllerFactory { }

extension AlbumFactory {
  public func makeAlbumListCoordinator(
    for albumID: Int,
    navigationController: UINavigationController,
    removeCoordinatorWith: @escaping (Coordinator?) -> Void
  ) -> AlbumListCoordinator {
    makeAlbumListCoordinator(
      for: albumID,
      navigationController: navigationController,
      viewControllerFactory: self,
      removeCoordinatorWith: removeCoordinatorWith
    )
  }
}

// MARK: - Coordinator Factory

public protocol AlbumCoordinatorFactory {
  func makeAlbumListCoordinator(
    for albumID: Int,
    navigationController: UINavigationController,
    viewControllerFactory: AlbumViewControllerFactory,
    removeCoordinatorWith: @escaping (Coordinator?) -> Void
  ) -> AlbumListCoordinator
}

extension AlbumCoordinatorFactory {
  public func makeAlbumListCoordinator(
    for albumID: Int,
    navigationController: UINavigationController,
    viewControllerFactory: AlbumViewControllerFactory,
    removeCoordinatorWith: @escaping (Coordinator?) -> Void
  ) -> AlbumListCoordinator {
    AlbumListCoordinator(
      for: albumID,
      navigationController: navigationController,
      viewControllerFactory: viewControllerFactory,
      removeCoordinatorWith: removeCoordinatorWith
    )
  }
}

// MARK: - View Controller Factory

public protocol AlbumViewControllerFactory {
  func makeAlbumListViewController(
    for albumID: Int,
    onAlbumSelection: @escaping (Int) -> Void
  ) -> UIViewController

  func makeAlbumDetailViewController(
    for albumID: Int,
    onTrackSelection: @escaping (Int) -> Void
  ) -> UIViewController
}
