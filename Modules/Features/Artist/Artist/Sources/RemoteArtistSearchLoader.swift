import Foundation
import Networking

public final class RemoteArtistSearchLoader: ArtistSearchLoader {

  private let client: HTTPClient
  private let url: URL

  public enum Error: Swift.Error {
    case connectivity
    case invalidData(InvalidDataError)
  }

  public enum InvalidDataError: Swift.Error {
    case statusCode(Int)
    case decoding(DecodingError)
    case unknown(Swift.Error)
  }

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

// TODO: Move to won file
extension RemoteArtistSearchLoader.Error: Equatable {
  public static func == (lhs: RemoteArtistSearchLoader.Error, rhs: RemoteArtistSearchLoader.Error) -> Bool {
    switch (lhs, rhs) {
    case (.connectivity, .connectivity),
         (.invalidData(.decoding(.valueNotFound)), .invalidData(.decoding(.valueNotFound))),
         (.invalidData(.decoding(.dataCorrupted)), .invalidData(.decoding(.dataCorrupted))),
         (.invalidData(.decoding(.typeMismatch)), .invalidData(.decoding(.typeMismatch))),
         (.invalidData(.decoding(.keyNotFound)), .invalidData(.decoding(.keyNotFound))),
         (.invalidData(.unknown), .invalidData(.unknown)):
      return true
    case (.invalidData(.statusCode(let A)), .invalidData(.statusCode(let B))):
      return A == B
    default:
      return false
    }
  }
}
