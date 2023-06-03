import Shared
import Track

final class TracksRowModelAdapter: ValueLoader {
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
