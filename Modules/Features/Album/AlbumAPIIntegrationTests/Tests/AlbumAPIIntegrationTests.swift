import Album
import Networking
import Testing
import XCTest

final class AlbumAPIIntegrationTests: XCTestCase {
  func test_albumsForArtistReturnsExpectedData() async throws {
    let albumsURL = URL(string: "https://api.deezer.com/artist/4768753/albums")!

    let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    let loader = RemoteAlbumsLoader(url: albumsURL, client: client)
    expectNoMemoryLeaks(for: client)
    expectNoMemoryLeaks(for: loader)

    do {
      let albums = try await loader.load()

      XCTAssertEqual(albums.count, 25)
      XCTAssertEqual(albums[0].id, 373401057)
      XCTAssertEqual(albums[0].title, "Thrill Of The Chase")
      XCTAssertEqual(albums[0].releaseDate, "2022-11-11".asISO8601FullDate())
      XCTAssertEqual(albums[0].hasExplicitLyrics, false)
    } catch {
      XCTFail("Expected successful albums result, got \(error) instead")
    }
  }
}

// TODO: Move to core
extension String {
  func asISO8601FullDate() -> Date? {
    let formatter = Formatter.iso8601
    formatter.formatOptions = [.withFullDate]

    return formatter.date(from: self)
  }
}

// TODO: Look for duplication here
extension Formatter {
  static let iso8601 = ISO8601DateFormatter()
}
