import UI
import UIKit

final class AppCoordinator {
  private let window: UIWindow
  private var childCoordinators = [Coordinator]()

  init(window: UIWindow) {
    self.window = window
  }

  func start() {
    let mainCoordinator = MainCoordinator(appWindow: window)
    mainCoordinator.start()
    childCoordinators = [mainCoordinator]
    window.makeKeyAndVisible()

    window.windowScene?.keyWindow?.tintColor = TrackAppAsset.accentColor.color
  }
}
