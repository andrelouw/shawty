import Core
import Shared
import UIKit

public protocol SharedCoordinatorDelegate { }

public final class SharedCoordinator: Coordinator {
  private let baseViewController: UIViewController

  public var delegate: SharedCoordinatorDelegate?

  public init(
    baseViewController: UIViewController
  ) {
    self.baseViewController = baseViewController
  }

  public func start() {
    baseViewController.show(viewController(), sender: self)
  }

  private func viewController() -> UIViewController {
    SharedViewController()
  }
}
