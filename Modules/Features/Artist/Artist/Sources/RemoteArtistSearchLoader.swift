import Foundation
import Networking

public final class RemoteArtistSearchLoader: ArtistSearchLoader {

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

  public func load(with query: String) async throws -> [Artist] {
    guard !query.isEmpty else {
      return []
    }

    var urlWithSearchQuery = url
    urlWithSearchQuery.append(queryItems: [.init(name: "q", value: query)])

    let response: HTTPClient.Response

    do {
      response = try await client.get(from: urlWithSearchQuery)
    } catch {
      throw Error.connectivity
    }

    return try ArtistsMapper.map(response.data, response.httpResponse)
  }
}
