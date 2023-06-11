import Album
import Shared
import SharedIOS
import UIIOS
import UIKit

struct AlbumListViewAdapter: ValueLoader {
  private let albumsLoader: any AlbumsLoader
  private let imageDataLoader: any ImageDataLoader

  init(
    albumsLoader: any AlbumsLoader,
    imageDataLoader: any ImageDataLoader
  ) {
    self.albumsLoader = albumsLoader
    self.imageDataLoader = imageDataLoader
  }

  func load() async throws -> [ImageTitleRowViewModel<Int>] {
    let albums = try await albumsLoader.load()

    return albums.map {
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
