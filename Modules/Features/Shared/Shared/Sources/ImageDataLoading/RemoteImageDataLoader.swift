import Foundation
import Networking

public final class RemoteImageDataLoader: ImageDataLoader {
  private let client: HTTPClient

  public typealias Error = RemoteLoadingError

  public init(client: HTTPClient) {
    self.client = client
  }

  public func load(_ url: URL) async throws -> Data {
    let response: HTTPClient.Response

    do {
      response = try await client.get(from: url)
    } catch {
      throw Error.connectivity
    }

    return try ImageDataMapper.map(response.data, response.httpResponse)
  }
}
