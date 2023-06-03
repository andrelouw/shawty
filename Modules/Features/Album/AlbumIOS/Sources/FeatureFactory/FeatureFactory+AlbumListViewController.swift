import Album
import Shared
import SharedIOS
import SwiftUI
import UIKit

extension FeatureFactory {
  func makeAlbumListViewController(
    for url: URL,
    onAlbumSelection: @escaping (Int) -> Void
  ) -> UIViewController {
    let remoteAlbumLoader = RemoteAlbumsLoader(
      url: url,
      client: httpClient
    )

    let remoteImageDataLoader = RemoteImageDataLoader(
      client: httpClient
    )

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

    let viewModel = ListViewModel(
      screenTitle: AlbumIOSStrings.albumSearchScreenTitle,
      contentLoader: contentStreamAdapter.load,
      onItemSelection: onAlbumSelection
    )

    return AlbumListViewController(
      listViewModel: viewModel
    )
  }
}
