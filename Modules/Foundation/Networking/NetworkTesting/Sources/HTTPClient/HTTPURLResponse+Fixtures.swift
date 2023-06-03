import Foundation

extension HTTPURLResponse {
  public static func response(
    for url: URL,
    withStatusCode statusCode: Int = 200
  ) -> HTTPURLResponse {
    HTTPURLResponse(
      url: url,
      statusCode: statusCode,
      httpVersion: nil,
      headerFields: [:]
    )!
  }
}
