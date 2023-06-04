import Album
import Core
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

  func test_albumForAlbumIDReturnsExpectedData() async throws {
    let albumURL = URL(string: "https://api.deezer.com/album/373401057")!

    let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    let loader = RemoteAlbumLoader(url: albumURL, client: client)
    expectNoMemoryLeaks(for: client)
    expectNoMemoryLeaks(for: loader)

    do {
      let album = try await loader.load()

      XCTAssertEqual(album.id, 373401057)
      XCTAssertEqual(album.title, "Thrill Of The Chase")
      XCTAssertEqual(album.releaseDate, "2022-11-11".asISO8601FullDate())
      XCTAssertEqual(album.hasExplicitLyrics, false)
    } catch {
      XCTFail("Expected successful albums result, got \(error) instead")
    }
  }
}
