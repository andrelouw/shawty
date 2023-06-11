import Artist
import Foundation
import Shared
import SharedIOS
import UIIOS
import UIKit

struct ArtistSearchListViewAdapter: QueryValueLoader {
  private let artistsSearchLoader: any ArtistSearchLoader
  private let imageDataLoader: any ImageDataLoader

  init(
    artistsSearchLoader: any ArtistSearchLoader,
    imageDataLoader: any ImageDataLoader
  ) {
    self.artistsSearchLoader = artistsSearchLoader
    self.imageDataLoader = imageDataLoader
  }

  func load(_ query: String) async throws -> [ImageTitleRowViewModel<Int>] {
    let artists = try await artistsSearchLoader.load(query)

    return artists.map {
      ImageTitleRowViewModel(
        model: $0.asImageTitleRowModel(),
        imageLoader: loadingImage(from:)
      )
    }
  }

  private func loadingImage(from url: URL) -> AsyncStream<LoadingImage> {
    ImageDataLoadingImageAdapter(
      imageDataLoader: imageDataLoader,
      dataImageAdapter: UIImage.init(data:)
    ).load(url)
  }
}
