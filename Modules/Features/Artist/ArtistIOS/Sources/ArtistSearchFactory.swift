import UIIOS
import UIKit

public protocol ArtistSearchFactory {
  func makeArtistSearchListCoordinator(
    navigationController: UINavigationController,
    removeCoordinatorWith: (Coordinator?) -> Void
  ) -> ArtistSearchListCoordinator

  func makeArtistSearchListViewController(
    onArtistSelection: @escaping (Int) -> Void
  ) -> ArtistSearchListViewController
}
