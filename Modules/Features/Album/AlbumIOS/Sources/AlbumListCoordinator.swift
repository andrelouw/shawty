import Foundation
import Shared
import UI
import UIKit

public protocol AlbumListCoordinatorDelegate {
  func didSelectAlbum(withID id: Int)
}

public final class AlbumListCoordinator: NSObject, Coordinator {
  public var navigationController: UINavigationController

  public var childCoordinators: [Coordinator] = []

  private let featureFactory: FeatureFactory
  private let albumListURL: URL

  public var delegate: AlbumListCoordinatorDelegate?
  private var removeCoordinatorWhenViewDismissed: (Coordinator) -> Void

  public init(
    albumListURL: URL,
    navigationController: UINavigationController,
    featureFactory: FeatureFactory,
    removeCoordinatorWith removeCoordinatorWhenViewDismissed: @escaping (Coordinator) -> Void
  ) {
    self.albumListURL = albumListURL
    self.navigationController = navigationController
    self.featureFactory = featureFactory
    self.removeCoordinatorWhenViewDismissed = removeCoordinatorWhenViewDismissed

    super.init()

    navigationController.delegate = self
  }

  public func start() {
    navigate(to: albumListViewController(), with: .push)
  }

  private func showAlbumDetail(for _: Int) {
    // TODO: Hook up album detail
  }

  private func albumListViewController() -> UIViewController {
    featureFactory
      .makeAlbumListViewController(for: albumListURL) { [weak self] id in
        guard let self else { return }
        delegate?.didSelectAlbum(withID: id)
        //        showAlbumDetail(for: id)
      }
  }
}

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
