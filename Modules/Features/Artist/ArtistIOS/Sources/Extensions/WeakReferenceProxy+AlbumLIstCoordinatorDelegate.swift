import Core

extension WeakRefVirtualProxy: ArtistSearchCoordinatorDelegate where T: ArtistSearchCoordinatorDelegate {
  public func didSelectArtist(withID id: Int) {
    object?.didSelectArtist(withID: id)
  }
}
