import Foundation
import Shared
import UIIOS
import UIKit

public protocol AlbumListCoordinatorDelegate {
  func didSelectTrack(withID id: Int)
}

/// The scene showing a list of `Album`s and showing more detail and `Track`s on a selected `Album`
public final class AlbumListCoordinator: NSObject, Coordinator {
  public let navigationController: UINavigationController
  public var childCoordinators: [Coordinator] = []

  private let viewControllerFactory: AlbumViewControllerFactory
  private let albumID: Int

  public var delegate: AlbumListCoordinatorDelegate?
  private var removeCoordinatorWhenViewDismissed: (Coordinator) -> Void

  public init(
    for albumID: Int,
    navigationController: UINavigationController,
    viewControllerFactory: AlbumViewControllerFactory,
    removeCoordinatorWith removeCoordinatorWhenViewDismissed: @escaping (Coordinator) -> Void
  ) {
    self.albumID = albumID
    self.navigationController = navigationController
    self.viewControllerFactory = viewControllerFactory
    self.removeCoordinatorWhenViewDismissed = removeCoordinatorWhenViewDismissed

    super.init()

    navigationController.delegate = self
  }

  public func start() {
    navigate(to: albumListViewController(), with: .push)
  }

  private func showAlbumDetail(for id: Int) {
    navigationController.show(albumDetailViewController(for: id), sender: self)
  }
}

extension AlbumListCoordinator {
  private func albumListViewController() -> UIViewController {
    viewControllerFactory
      .makeAlbumListViewController(for: albumID) { [weak self] id in
        self?.showAlbumDetail(for: id)
      }
  }

  private func albumDetailViewController(for id: Int) -> UIViewController {
    viewControllerFactory
      .makeAlbumDetailViewController(for: id) { [weak self] id in
        self?.delegate?.didSelectTrack(withID: id)
      }
  }
}

// MARK: - UINavigationControllerDelegate

extension AlbumListCoordinator: UINavigationControllerDelegate {
  public func navigationController(
    _ navigationController: UINavigationController,
    didShow _: UIViewController,
    animated _: Bool
  ) {
    guard
      let viewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
      !navigationController.viewControllers.contains(viewController)
    else {
      return
    }

    if viewController is AlbumListViewController {
      removeCoordinatorWhenViewDismissed(self)
    }
  }
}
