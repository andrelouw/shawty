import ArtistIOS
import UI
import UIKit

public final class MainCoordinator: Coordinator {
  public lazy var navigationController = UINavigationController()
  public var childCoordinators = [Coordinator]()

  private let appWindow: UIWindow

  public init(appWindow: UIWindow) {
    self.appWindow = appWindow
  }

  public func start() {
    appWindow.rootViewController = navigationController

    let artistSearchCoordinator = ArtistSearchSceneCoordinator(
      with: navigationController
    )

    addChild(artistSearchCoordinator)
    artistSearchCoordinator.start()
  }
}
