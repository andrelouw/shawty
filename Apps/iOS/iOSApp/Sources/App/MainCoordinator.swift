import ArtistIOS
import UI
import UIKit

final class MainCoordinator: Coordinator {
  lazy var navigationController = UINavigationController()

  public var childCoordinators = [Coordinator]()
  private let appWindow: UIWindow

  init(appWindow: UIWindow) {
    self.appWindow = appWindow
  }

  func start() {
    appWindow.rootViewController = navigationController

    let artistSearchCoordinator = ArtistSearchSceneCoordinator(
      with: navigationController
    )

    addChild(artistSearchCoordinator)
    artistSearchCoordinator.start()
  }
}
