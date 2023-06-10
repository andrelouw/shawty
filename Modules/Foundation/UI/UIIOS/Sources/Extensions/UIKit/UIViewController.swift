#if canImport(UIKit)
import SwiftUI
import UIKit

extension UIViewController {
  public func embed(_ viewController: UIViewController) {
    addChild(viewController)
    view.addSubview(viewController.view)
    viewController.view.frame = view.bounds
    viewController.didMove(toParent: self)
  }

  public func embed(_ view: some View) {
    let hostingController = UIHostingController(rootView: view)
    embed(hostingController)
  }
}

#endif
