import UIIOS
import UIKit

public protocol TrackFactory: TrackCoordinatorFactory, TrackViewControllerFactory { }

extension TrackFactory {
  public func makeTrackListCoordinator(
    for albumID: Int,
    navigationController: UINavigationController,
    removeCoordinatorWith: @escaping (Coordinator?) -> Void
  ) -> TrackListCoordinator {
    makeTrackListCoordinator(
      for: albumID,
      navigationController: navigationController,
      viewControllerFactory: self,
      removeCoordinatorWith: removeCoordinatorWith
    )
  }
}

// MARK: - Coordinator Factory

public protocol TrackCoordinatorFactory {
  func makeTrackListCoordinator(
    for albumID: Int,
    navigationController: UINavigationController,
    viewControllerFactory: TrackViewControllerFactory,
    removeCoordinatorWith: @escaping (Coordinator?) -> Void
  ) -> TrackListCoordinator
}

extension TrackCoordinatorFactory {
  public func makeTrackListCoordinator(
    for albumID: Int,
    navigationController: UINavigationController,
    viewControllerFactory: TrackViewControllerFactory,
    removeCoordinatorWith: @escaping (Coordinator?) -> Void
  ) -> TrackListCoordinator {
    TrackListCoordinator(
      for: albumID,
      navigationController: navigationController,
      viewControllerFactory: viewControllerFactory,
      removeCoordinatorWith: removeCoordinatorWith
    )
  }
}

// MARK: - View Controller Factory

public protocol TrackViewControllerFactory {
  func makeTrackListViewController(
    for albumID: Int,
    onAlbumSelection: @escaping (Int) -> Void
  ) -> UIViewController
}
