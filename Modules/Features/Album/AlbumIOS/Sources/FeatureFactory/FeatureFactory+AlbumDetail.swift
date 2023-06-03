import Album
import Foundation
import Shared
import SharedIOS
import SwiftUI
import Track
import TrackIOS
import UI
import UIKit

extension FeatureFactory {
  public func makeAlbumDetailViewController(
    for id: Int,
    onTrackSelection: @escaping (Int) -> Void
  ) -> UIViewController {
    let remoteAlbumLoader = RemoteAlbumLoader(
      url: albumTracksURL(forAlbumID: id),
      client: httpClient
    )

    let remoteImageDataLoader = RemoteImageDataLoader(
      client: httpClient
    )

    let albumDetailHeaderModelAdapter = AlbumDetailHeaderModelAdapter(
      albumLoader: remoteAlbumLoader
    )

    let imageDataLoadingImageAdapter = ImageDataLoadingImageAdapter(
      imageDataLoader: remoteImageDataLoader,
      dataImageAdapter: UIImage.init(data:)
    )

    let viewModel = AlbumDetailViewModel(
      detailLoader: albumDetailHeaderModelAdapter.load,
      imageLoader: imageDataLoadingImageAdapter.load
    )

    let view = AlbumDetailView(
      viewModel: viewModel
    ) {
      makeTrackListView(
        for: albumTracksURL(forAlbumID: id),
        screenTitle: nil,
        sectionTitle: TrackIOSStrings.trackListScreenTitle,
        onTrackSelection: onTrackSelection
      )
    }

    return UIHostingController(rootView: view)
  }
}
