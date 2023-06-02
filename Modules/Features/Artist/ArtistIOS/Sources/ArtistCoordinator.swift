import Artist
import Core
import UIKit

public protocol ArtistCoordinatorDelegate { }

public final class ArtistCoordinator: Coordinator {
  private let baseViewController: UIViewController

  public var delegate: ArtistCoordinatorDelegate?

  public init(
    baseViewController: UIViewController
  ) {
    self.baseViewController = baseViewController
  }

  public func start() {
    baseViewController.show(viewController(), sender: self)
  }

  private func viewController() -> UIViewController {
    ArtistViewController()
  }
}
