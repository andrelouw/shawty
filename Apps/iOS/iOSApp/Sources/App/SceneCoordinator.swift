import UIIOS
import UIKit

/// The coordinator for the active scene
final class SceneCoordinator {
  private let window: UIWindow
  private var childCoordinators = [Coordinator]()

  init(scene: UIWindowScene) {
    window = UIWindow(windowScene: scene)
  }

  func start() {
    let mainCoordinator = MainCoordinator(appWindow: window)
    mainCoordinator.start()
    childCoordinators = [mainCoordinator]
    window.makeKeyAndVisible()

    window.windowScene?.keyWindow?.tintColor = ShawtyAsset.accentColor.color
  }
}
