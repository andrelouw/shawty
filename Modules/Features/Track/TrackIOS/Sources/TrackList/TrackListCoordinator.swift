import Foundation
import Shared
import UIIOS
import UIKit

public protocol TrackListCoordinatorDelegate {
  func didSelectTrack(withID id: Int)
}

/// The scene showing a list of `Track`s from a given album ID
public final class TrackListCoordinator: NSObject, Coordinator {
  public var navigationController: UINavigationController
  public var childCoordinators: [Coordinator] = []

  private let viewControllerFactory: TrackViewControllerFactory
  private let albumID: Int

  public var delegate: TrackListCoordinatorDelegate?
  private var removeCoordinatorWhenViewDismissed: (Coordinator) -> Void

  public init(
    for albumID: Int,
    navigationController: UINavigationController,
    viewControllerFactory: TrackViewControllerFactory,
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
    navigate(to: trackListViewController(), with: .push)
  }
}

extension TrackListCoordinator {
  private func trackListViewController() -> UIViewController {
    viewControllerFactory
      .makeTrackListViewController(for: albumID) { [weak self] id in
        self?.delegate?.didSelectTrack(withID: id)
      }
  }
}

// MARK: -- Factory Methods

extension TrackListCoordinator: UINavigationControllerDelegate {
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

    if viewController is TrackListViewController {
      removeCoordinatorWhenViewDismissed(self)
    }
  }
}
