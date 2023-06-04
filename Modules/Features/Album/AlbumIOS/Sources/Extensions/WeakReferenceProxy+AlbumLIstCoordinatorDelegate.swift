import Core

extension WeakRefVirtualProxy: AlbumListCoordinatorDelegate where T: AlbumListCoordinatorDelegate {
  public func didSelectTrack(withID id: Int) {
    object?.didSelectTrack(withID: id)
  }
}
