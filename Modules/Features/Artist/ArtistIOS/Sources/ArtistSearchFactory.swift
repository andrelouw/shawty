
public protocol ArtistSearchFactory {
  func makeArtistSearchListViewController(
    onArtistSelection: @escaping (Int) -> Void
  ) -> ArtistSearchListViewController
}
