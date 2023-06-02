import Artist
import ArtistIOS
import Core
import Networking
import Shared
import SharedIOS
import UI
import UIKit

public final class MainCoordinator: Coordinator, FeatureFactory {
  private var navigationController: UINavigationController
  private var childCoordinators = [Coordinator]()

  public let baseURL = URL(string: "https://api.deezer.com")!
  public lazy var httpClient: HTTPClient = URLSessionHTTPClient(session: .shared)
  public lazy var imageLoader: any ImageDataLoader = RemoteImageDataLoader(client: httpClient)

  public init(appWindow: UIWindow) {
    navigationController = UINavigationController()
    appWindow.rootViewController = navigationController
  }

  public func start() {
    navigationController.show(artistSearchListViewController(), sender: self)
  }

  private func artistSearchListViewController() -> UIViewController {
    makeArtistSearchViewController(onArtistSelection: didSelectTrack)
  }

  private func didSelectTrack(withID id: Int) {
    let alert = UIAlertController(
      title: "Artist Selected",
      message: "Artist ID: \(id)",
      preferredStyle: .alert
    )

    alert.addAction(
      UIAlertAction(
        title: "OK",
        style: .default
      )
    )

    navigationController.present(alert, animated: true)
  }
}
