import Networking
import Testing
import Track
import XCTest

final class TrackAPIIntegrationTests: XCTestCase {
  func test_searchForArtistReturnsExpectedData() async throws {
    let albumsURL = URL(string: "https://api.deezer.com/album/373401057/tracks")!

    let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    let loader = RemoteTracksLoader(url: albumsURL, client: client)
    expectNoMemoryLeaks(for: client)
    expectNoMemoryLeaks(for: loader)

    do {
      let artists = try await loader.load()

      XCTAssertEqual(artists.count, 14)
      XCTAssertEqual(artists[0].id, 2005342687)
      XCTAssertEqual(artists[0].title, "Gone Are The Days (feat. James Gillespie)")
    } catch {
      XCTFail("Expected successful albums result, got \(error) instead")
    }
  }
}
