import Album
import Shared
import UI

/// Adapt `AlbumLoader` output to provide an optional `DetailHeaderModel`
struct AlbumDetailHeaderModelAdapter: ValueLoader {
  private let albumLoader: any AlbumLoader

  init(
    albumLoader: any AlbumLoader
  ) {
    self.albumLoader = albumLoader
  }

  func load() async -> DetailHeaderModel? {
    guard let album = try? await albumLoader.load() else {
      return nil
    }

    return album.asDetailHeaderModel()
  }
}
