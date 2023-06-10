import Foundation
import Shared
import UIIOS
import UIKit

public protocol TrackListCoordinatorDelegate {
  func didSelectTrack(withID id: Int)
}

/// The scene showing a list of `Track`s from a given url
public final class TrackListCoordinator: NSObject, Coordinator {
  public var navigationController: UINavigationController
  public var childCoordinators: [Coordinator] = []

  private let featureFactory: FeatureFactory
  private let trackListURL: URL

  public var delegate: TrackListCoordinatorDelegate?
  private var removeCoordinatorWhenViewDismissed: (Coordinator) -> Void

  public init(
    trackListURL: URL,
    navigationController: UINavigationController,
    featureFactory: FeatureFactory,
    removeCoordinatorWith removeCoordinatorWhenViewDismissed: @escaping (Coordinator) -> Void
  ) {
    self.trackListURL = trackListURL
    self.navigationController = navigationController
    self.featureFactory = featureFactory
    self.removeCoordinatorWhenViewDismissed = removeCoordinatorWhenViewDismissed

    super.init()

    navigationController.delegate = self
  }

  public func start() {
    navigate(to: trackListViewController(), with: .push)
  }

  private func trackListViewController() -> UIViewController {
    featureFactory.makeTrackListViewController(
      for: trackListURL,
      onTrackSelection: { [weak self] id in
        guard let self else { return }
        delegate?.didSelectTrack(withID: id)
      }
    )
  }
}

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
