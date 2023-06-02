import Networking
import Shared
import Testing
import XCTest

final class SharedAPIIntegrationTests: XCTestCase {
  func test_loadImageDataFromURLReturnsNonEmptyData() async throws {
    let imageURL =
      URL(string: "https://e-cdns-images.dzcdn.net/images/artist/df5ebed126f2e7402769782dae1e8c68/56x56-000000-80-0-0.jpg")!

    let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    let loader = RemoteImageDataLoader(client: client)
    expectNoMemoryLeaks(for: client)
    expectNoMemoryLeaks(for: loader)

    do {
      let data = try await loader.load(with: imageURL)

      XCTAssertFalse(data.isEmpty)
    } catch {
      XCTFail("Expected successful artists result, got \(error) instead")
    }
  }
}
