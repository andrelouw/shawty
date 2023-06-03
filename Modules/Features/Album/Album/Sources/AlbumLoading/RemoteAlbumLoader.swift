import Foundation
import Networking

public final class RemoteAlbumLoader: AlbumLoader {
  private let client: HTTPClient
  private let url: URL

  public typealias Error = RemoteLoadingError

  public init(
    url: URL,
    client: HTTPClient
  ) {
    self.url = url
    self.client = client
  }

  public func load() async throws -> Album {
    let response: HTTPClient.Response

    do {
      response = try await client.get(from: url)
    } catch {
      throw Error.connectivity
    }

    return try AlbumMapper.map(response.data, response.httpResponse)
  }
}
