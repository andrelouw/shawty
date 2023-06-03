import Foundation
import Shared
import UI
import UIKit

public protocol AlbumListCoordinatorDelegate {
  func didSelectTrack(withID id: Int)
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

  private func showAlbumDetail(for id: Int) {
    navigationController.show(albumDetailViewController(for: id), sender: self)
  }

  private func albumListViewController() -> UIViewController {
    featureFactory
      .makeAlbumListViewController(for: albumListURL) { [weak self] id in
        guard let self else { return }
        showAlbumDetail(for: id)
      }
  }

  private func albumDetailViewController(for id: Int) -> UIViewController {
    featureFactory
      .makeAlbumDetailViewController(for: id) { [weak self] id in
        self?.delegate?.didSelectTrack(withID: id)
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
