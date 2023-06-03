import Album
import Shared
import SharedIOS
import SwiftUI
import UIKit

extension FeatureFactory {
  /// Creates a `AlbumListViewController` that will load `Albums` from the given `URL`
  /// - Parameters:
  ///   - url: The `URL` used to populate the view with albums
  ///   - onAlbumSelection: The action to take when an `Album` is selected on the list view
  /// - Returns: A `AlbumListViewController`
  func makeAlbumListViewController(
    for url: URL,
    onAlbumSelection: @escaping (Int) -> Void
  ) -> UIViewController {
    // Loaders
    let remoteAlbumLoader = RemoteAlbumsLoader(
      url: url,
      client: httpClient
    )

    let remoteImageDataLoader = RemoteImageDataLoader(
      client: httpClient
    )

    // Adapters
    let imageDataLoadingImageAdapter = ImageDataLoadingImageAdapter(
      imageDataLoader: remoteImageDataLoader,
      dataImageAdapter: UIImage.init(data:)
    )

    let albumsViewModelAdapter = AlbumImageTitleRowViewModelAdapter(
      albumsLoader: remoteAlbumLoader,
      imageDataLoadingImageAdapter: imageDataLoadingImageAdapter
    )

    let contentStreamAdapter = ValueLoaderContentStreamAdapter(
      loader: albumsViewModelAdapter
    )

    // ViewModel
    let viewModel = ListViewModel(
      contentLoader: contentStreamAdapter.load,
      onItemSelection: onAlbumSelection
    )

    // View Controller
    return AlbumListViewController(
      screenTitle: AlbumIOSStrings.albumSearchScreenTitle,
      listViewModel: viewModel
    )
  }
}
