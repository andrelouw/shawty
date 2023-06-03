import Shared
import UI
import UIKit

public final class MainCoordinator: Coordinator {
  public var navigationController: UINavigationController
  public var childCoordinators = [Coordinator]()

  public init(appWindow: UIWindow) {
    navigationController = UINavigationController()
    appWindow.rootViewController = navigationController
  }

  // No launching any features, but keeping the app to have an executable target in the module for SwiftUI views etc
  public func start() { }
}
