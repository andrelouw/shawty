import Album
import Foundation
import Shared
import SharedIOS
import UIKit

/// Adapts `AlbumsLoader` output to provide `[ImageTitleRowViewModel<Int>]`
struct AlbumImageTitleRowViewModelAdapter: ValueLoader {
  private let albumsLoader: any AlbumsLoader
  private let imageDataLoadingImageAdapter: ImageDataLoadingImageAdapter

  init(
    albumsLoader: any AlbumsLoader,
    imageDataLoadingImageAdapter: ImageDataLoadingImageAdapter
  ) {
    self.albumsLoader = albumsLoader
    self.imageDataLoadingImageAdapter = imageDataLoadingImageAdapter
  }

  func load() async throws -> [ImageTitleRowViewModel<Int>] {
    let albums = try await albumsLoader.load()

    return albums.map {
      .init(
        model: $0.asImageTitleRowModel(),
        imageLoader: imageDataLoadingImageAdapter.load
      )
    }
  }
}
