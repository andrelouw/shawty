import Artist
import SharedIOS

/// Adapts ArtistSearchLoading to ImageTitleRowViewModel
struct ArtistImageTitleRowViewModelAdapter {
  private let artistsSearchLoader: any ArtistSearchLoader
  private let imageDataLoadingImageAdapter: ImageDataLoadingImageAdapter

  init(
    artistsSearchLoader: any ArtistSearchLoader,
    imageDataLoadingImageAdapter: ImageDataLoadingImageAdapter
  ) {
    self.artistsSearchLoader = artistsSearchLoader
    self.imageDataLoadingImageAdapter = imageDataLoadingImageAdapter
  }

  func load(with query: String) async throws -> [ImageTitleRowViewModel<Int>] {
    let artists = try await artistsSearchLoader.load(query)

    return artists.map {
      ImageTitleRowViewModel(
        model: $0.asImageTitleRowModel(),
        imageLoader: imageDataLoadingImageAdapter.load
      )
    }
  }
}
