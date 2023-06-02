import Foundation
import Networking

public final class RemoteImageDataLoader: ImageDataLoader {
  private let client: HTTPClient

  public enum Error: Swift.Error {
    case connectivity
    case invalidData(InvalidDataError)
  }

  public enum InvalidDataError: Swift.Error {
    case statusCode(Int)
    case decoding(DecodingError)
    case unknown(Swift.Error)
  }

  public init(client: HTTPClient) {
    self.client = client
  }

  public func load(with url: URL) async throws -> Data {
    let response: HTTPClient.Response

    do {
      response = try await client.get(from: url)
    } catch {
      throw Error.connectivity
    }

    return try ImageDataMapper.map(response.data, response.httpResponse)
  }
}
