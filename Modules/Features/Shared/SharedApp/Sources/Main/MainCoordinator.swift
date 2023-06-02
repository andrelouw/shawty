import Core
import Shared
import UIKit

public final class MainCoordinator: Coordinator {
  private var navigationController: UINavigationController
  private var childCoordinators = [Coordinator]()

  public init(appWindow: UIWindow) {
    navigationController = UINavigationController()
    appWindow.rootViewController = navigationController
  }

  public func start() {
    let coordinator = SharedCoordinator(
      appName: Bundle.main.displayName ?? "App",
      navigationController: navigationController
    )

    coordinator.start()
    childCoordinators = [coordinator]
  }
}
