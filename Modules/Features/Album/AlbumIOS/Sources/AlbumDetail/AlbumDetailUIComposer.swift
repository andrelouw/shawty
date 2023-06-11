import Album
import Shared
import SharedIOS
import SwiftUI
import UIIOS
import UIKit

public enum AlbumDetailUIComposer {
  private typealias AlbumDetailContentLoader = AlbumDetailViewModel.DetailLoader
  private typealias ImageLoader = AlbumDetailViewModel.ImageLoader

  public static func detailComposedWith(
    albumLoader: any AlbumLoader,
    imageDataLoader: any ImageDataLoader,
    listView: @escaping () -> some View
  ) -> UIViewController {
    let albumDetailViewModel = AlbumDetailViewModel(
      detailLoader: albumDetailLoader(from: albumLoader),
      imageLoader: imageLoader(from: imageDataLoader)
    )

    return AlbumDetailViewController(
      albumViewModel: albumDetailViewModel,
      listView: listView
    )
  }

  private static func albumDetailLoader(
    from albumLoader: any AlbumLoader
  ) -> AlbumDetailContentLoader {
    AlbumDetailViewAdapter(
      albumLoader: albumLoader
    ).load
  }

  private static func imageLoader(
    from imageDataLoader: any ImageDataLoader
  ) -> ImageLoader {
    ImageDataLoadingImageAdapter(
      imageDataLoader: imageDataLoader,
      dataImageAdapter: UIImage.init(data:)
    ).load
  }
}
