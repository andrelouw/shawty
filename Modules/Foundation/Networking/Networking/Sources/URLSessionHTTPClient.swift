import Foundation

public final class URLSessionHTTPClient: HTTPClient {
  private let session: URLSession

  public enum Error: Swift.Error {
    case unexpectedResponseType
  }

  public init(session: URLSession) {
    self.session = session
  }

  public func get(from url: URL) async throws -> Response {
    let (data, response) = try await session.data(from: url)

    try await Task.sleep(for: .seconds(2))

    if let response = response as? HTTPURLResponse {
      return (data, response)
    } else {
      throw Error.unexpectedResponseType
    }
  }
}
