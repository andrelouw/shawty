#if canImport(UIKit)
import UIKit

public protocol Coordinator: AnyObject {
  var navigationController: UINavigationController { get }
  var childCoordinators: [Coordinator] { get set }

  func start()
}

extension Coordinator {

  public func addChild(_ coordinator: Coordinator) {
    childCoordinators.append(coordinator)
  }

  public func removeChild(_ childCoordinator: Coordinator?) {
    for (index, coordinator) in childCoordinators.enumerated() {
      if coordinator === childCoordinator {
        childCoordinators.remove(at: index)
        break
      }
    }
  }

}

extension Coordinator {
  public func navigate(to viewController: UIViewController, with presentationStyle: NavigationStyle, animated: Bool = true) {
    switch presentationStyle {
    case .present:
      navigationController.present(viewController, animated: animated, completion: nil)
    case .push:
      navigationController.pushViewController(viewController, animated: true)
    }
  }

}

public enum NavigationStyle {
  case present
  case push
}

#endif
