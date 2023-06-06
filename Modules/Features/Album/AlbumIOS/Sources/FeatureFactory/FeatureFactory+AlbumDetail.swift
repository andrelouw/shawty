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
  /// Creates a `AlbumDetailViewController` that will load the `Album` details  and `Track`s for a given `id`
  /// - Parameters:
  ///   - id: The `Album` id for the detail view
  ///   - onTrackSelection: The action to take when a `Track` is selected on the detail view
  /// - Returns: A `AlbumDetailViewController`
  func makeAlbumDetailViewController(
    for id: Int,
    onTrackSelection: @escaping (Int) -> Void
  ) -> UIViewController {
    // Loaders
    let remoteAlbumLoader = RemoteAlbumLoader(
      url: albumDetailURL(forAlbumID: id),
      client: httpClient
    )

    // Adapters
    let albumDetailHeaderModelAdapter = AlbumDetailHeaderModelAdapter(
      albumLoader: remoteAlbumLoader
    )

    let imageDataLoadingImageAdapter = ImageDataLoadingImageAdapter(
      imageDataLoader: imageLoader,
      dataImageAdapter: UIImage.init(data:)
    )

    // ViewModels
    let albumDetailViewModel = AlbumDetailViewModel(
      detailLoader: albumDetailHeaderModelAdapter.load,
      imageLoader: imageDataLoadingImageAdapter.load
    )

    let trackListViewModel = makeTrackListViewModel(
      for: albumTracksURL(forAlbumID: id),
      sectionTitle: TrackIOSStrings.trackListScreenTitle,
      onTrackSelection: onTrackSelection
    )

    // View Controller
    return AlbumDetailViewController(
      albumViewModel: albumDetailViewModel,
      listViewModel: trackListViewModel
    )
  }
}
