#if canImport(UIKit)
import UIKit

extension UIViewController {
  public func embed(viewController: UIViewController, frame _: CGRect? = nil) {
    addChild(viewController)
    view.addSubview(viewController.view)
    viewController.view.frame = view.bounds
    viewController.didMove(toParent: self)
  }
}

#endif
