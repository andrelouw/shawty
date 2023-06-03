import Foundation

public protocol HTTPClient {
  typealias Response = (data: Data, httpResponse: HTTPURLResponse)

  func get(from url: URL) async throws -> Response
}
