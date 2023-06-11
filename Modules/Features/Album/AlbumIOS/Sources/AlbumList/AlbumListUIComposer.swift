import Album
import Shared
import SharedIOS
import UIIOS
import UIKit

public enum AlbumListUIComposer {
  private typealias AlbumContentStreamLoader = () -> ContentViewStream<[ImageTitleRowViewModel<Int>]>

  public static func listComposedWith(
    albumLoader: any AlbumsLoader,
    imageDataLoader: any ImageDataLoader,
    selection: @escaping (Int) -> Void
  ) -> UIViewController {
    let viewModel = ListViewModel(
      contentLoader: albumContentStreamLoader(
        albumLoader: albumLoader,
        imageDataLoader: imageDataLoader
      ),
      onItemSelection: selection
    )

    return AlbumListViewController(
      screenTitle: AlbumIOSStrings.albumSearchScreenTitle,
      listViewModel: viewModel
    )
  }

  private static func albumContentStreamLoader(
    albumLoader: any AlbumsLoader,
    imageDataLoader: any ImageDataLoader
  ) -> AlbumContentStreamLoader {
    let albumListViewAdapter = AlbumListViewAdapter(
      albumsLoader: albumLoader,
      imageDataLoader: imageDataLoader
    )

    return ValueLoaderContentStreamAdapter(
      loader: albumListViewAdapter
    ).load
  }
}
