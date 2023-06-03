import Album
import UI

struct AlbumDetailHeaderModelAdapter {
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
