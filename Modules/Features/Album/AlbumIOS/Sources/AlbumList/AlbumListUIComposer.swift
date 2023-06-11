import Album
import Shared
import SharedIOS
import UIIOS
import UIKit

public enum AlbumListUIComposer {
  private typealias AlbumContentStreamLoader = () -> ContentViewStream<[ImageTitleRowViewModel<Int>]>

  public static func listComposedWith(
    albumsLoader: any AlbumsLoader,
    imageDataLoader: any ImageDataLoader,
    selection: @escaping (Int) -> Void
  ) -> UIViewController {
    let viewModel = ListViewModel(
      contentLoader: albumsContentStreamLoader(
        albumsLoader: albumsLoader,
        imageDataLoader: imageDataLoader
      ),
      onItemSelection: selection
    )

    return AlbumListViewController(
      screenTitle: AlbumIOSStrings.albumSearchScreenTitle,
      listViewModel: viewModel
    )
  }

  private static func albumsContentStreamLoader(
    albumsLoader: any AlbumsLoader,
    imageDataLoader: any ImageDataLoader
  ) -> AlbumContentStreamLoader {
    let albumListViewAdapter = AlbumListViewAdapter(
      albumsLoader: albumsLoader,
      imageDataLoader: imageDataLoader
    )

    return ValueLoaderContentStreamAdapter(
      loader: albumListViewAdapter
    ).load
  }
}
