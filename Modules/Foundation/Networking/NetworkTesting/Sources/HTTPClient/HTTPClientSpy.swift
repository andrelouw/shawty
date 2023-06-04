import Core
import Foundation
import Networking

public final class HTTPClientSpy: HTTPClient {
  public typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

  public private(set) var requestedURLs = [URL]()
  private var results = [Result]()

  public init() { }

  public func get(from url: URL) async throws -> Response {
    requestedURLs.append(url)

    return try result(at: requestedURLs.count - 1, for: url).get()
  }

  public func complete(withError error: Error, at index: Int = 0) {
    results.insert(.failure(error), at: index)
  }

  public func complete(
    withStatusCode code: Int,
    data: Data,
    for url: URL,
    at index: Int = 0
  ) {
    let response = HTTPURLResponse.response(for: url, withStatusCode: code)
    results.insert(.success((data, response)), at: index)
  }

  private func result(at index: Int, for url: URL) -> Result {
    guard let result = results[safe: index] else {
      return .success((
        Data(),
        .response(for: url)
      ))
    }

    return result
  }
}
