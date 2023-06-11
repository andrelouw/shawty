import Artist
import Shared
import UIIOS
import UIKit

public protocol ArtistSearchCoordinatorDelegate {
  func didSelectArtist(withID id: Int)
}

/// The scene showing a list of `Artist`s based on a given typed search query
public final class ArtistSearchListCoordinator: NSObject, Coordinator {
  public let navigationController: UINavigationController
  public var childCoordinators: [Coordinator] = []
  public var delegate: ArtistSearchCoordinatorDelegate?

  private let artistSearchFactory: ArtistSearchFactory
  private var removeCoordinatorWhenViewDismissed: (Coordinator) -> Void

  public init(
    navigationController: UINavigationController,
    artistSearchFactory: ArtistSearchFactory,
    removeCoordinatorWith removeCoordinatorWhenViewDismissed: @escaping (Coordinator) -> Void
  ) {
    self.navigationController = navigationController
    self.artistSearchFactory = artistSearchFactory
    self.removeCoordinatorWhenViewDismissed = removeCoordinatorWhenViewDismissed

    super.init()

    navigationController.delegate = self
  }

  public func start() {
    navigate(to: artistSearchViewController(), with: .push)
  }
}

// MARK: -- Factory Methods

extension ArtistSearchListCoordinator {
  private func artistSearchViewController() -> UIViewController {
    artistSearchFactory.makeArtistSearchListViewController { [weak self] id in
      guard let self else { return }
      delegate?.didSelectArtist(withID: id)
    }
  }
}

// MARK: - UINavigationControllerDelegate

extension ArtistSearchListCoordinator: UINavigationControllerDelegate {
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

    if viewController is ArtistSearchListViewController {
      removeCoordinatorWhenViewDismissed(self)
    }
  }
}
