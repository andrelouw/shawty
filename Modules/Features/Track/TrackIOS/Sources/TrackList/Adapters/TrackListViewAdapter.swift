import Shared
import Track

struct TrackListViewAdapter: ValueLoader {
  private let tracksLoader: any TracksLoader

  init(
    tracksLoader: any TracksLoader
  ) {
    self.tracksLoader = tracksLoader
  }

  func load() async throws -> [TrackRowModel<Int>] {
    let tracks = try await tracksLoader.load()

    return tracks
      .map {
        $0.asTrackRowModel()
      }
  }
}
