import AlbumIOS
import UIKit

extension LiveFeatureFactory: AlbumFactory {
  func makeAlbumListViewController(
    for _: Int,
    onAlbumSelection _: @escaping (Int) -> Void
  ) -> UIViewController {
    .init()
  }

  func makeAlbumDetailViewController(
    for _: Int,
    onTrackSelection _: @escaping (Int) -> Void
  ) -> UIViewController {
    .init()
  }
}
