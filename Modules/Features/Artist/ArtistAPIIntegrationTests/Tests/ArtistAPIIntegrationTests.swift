import Artist
import Networking
import Testing
import XCTest

final class ArtistAPIIntegrationTests: XCTestCase {
  func test_searchForArtistReturnsExpectedData() async throws {
    let artistSearchURL = URL(string: "https://api.deezer.com/search/artist")!

    let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    let loader = RemoteArtistSearchLoader(url: artistSearchURL, client: client)
    expectNoMemoryLeaks(for: client)
    expectNoMemoryLeaks(for: loader)

    do {
      let artists = try await loader.load(with: "kygo")

      XCTAssertEqual(artists.count, 25)
      XCTAssertEqual(artists[0].id, 4768753)
      XCTAssertEqual(artists[0].name, "Kygo")
    } catch {
      XCTFail("Expected successful artists result, got \(error) instead")
    }
  }
}
