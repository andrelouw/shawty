import Artist
import Shared
import SharedIOS

/// Adapt `ArtistSearchLoading` output to provide to `ImageTitleRowViewModel`s
struct ArtistImageTitleRowViewModelAdapter: QueryValueLoader {
  private let artistsSearchLoader: any ArtistSearchLoader
  private let imageDataLoadingImageAdapter: ImageDataLoadingImageAdapter

  init(
    artistsSearchLoader: any ArtistSearchLoader,
    imageDataLoadingImageAdapter: ImageDataLoadingImageAdapter
  ) {
    self.artistsSearchLoader = artistsSearchLoader
    self.imageDataLoadingImageAdapter = imageDataLoadingImageAdapter
  }

  func load(_ query: String) async throws -> [ImageTitleRowViewModel<Int>] {
    let artists = try await artistsSearchLoader.load(query)

    return artists.map {
      ImageTitleRowViewModel(
        model: $0.asImageTitleRowModel(),
        imageLoader: imageDataLoadingImageAdapter.load
      )
    }
  }
}
