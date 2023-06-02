import UI
import UIKit

public final class MainCoordinator: Coordinator {
  public var navigationController: UINavigationController
  public var childCoordinators = [Coordinator]()

  public init(appWindow: UIWindow) {
    navigationController = UINavigationController()
    appWindow.rootViewController = navigationController
  }

  public func start() { }
}
