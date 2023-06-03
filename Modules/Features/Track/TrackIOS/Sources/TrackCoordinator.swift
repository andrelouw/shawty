import Core
import Track
import UIKit

public protocol TrackCoordinatorDelegate { }

public final class TrackCoordinator: Coordinator {
  private let baseViewController: UIViewController

  public var delegate: TrackCoordinatorDelegate?

  public init(
    baseViewController: UIViewController
  ) {
    self.baseViewController = baseViewController
  }

  public func start() {
    baseViewController.show(viewController(), sender: self)
  }

  private func viewController() -> UIViewController {
    TrackViewController()
  }
}
