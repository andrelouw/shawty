import Core

extension WeakRefVirtualProxy: TrackListCoordinatorDelegate where T: TrackListCoordinatorDelegate {
  public func didSelectTrack(withID id: Int) {
    object?.didSelectTrack(withID: id)
  }
}
