import Foundation

extension JSONDecoder {
  /// Default decoder for the project
  ///
  /// Uses `ISO8601DateFormatter` with `withFullDate` date decoding strategy for string dates
  /// Throws `DecodingError.dataCorruptedError` if date is not valid
  ///
  /// Also uses the `convertFromSnakeCase` as `keyDecodingStratgy`
  public static let `default` = makeDefaultJSONDecoder()

  // Reference: https://sarunw.com/posts/how-to-parse-iso8601-date-in-swift/
  static func makeDefaultJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withFullDate]

    decoder.keyDecodingStrategy = .convertFromSnakeCase

    decoder.dateDecodingStrategy = .custom { decoder in
      let container = try decoder.singleValueContainer()
      let dateString = try container.decode(String.self)

      if let date = formatter.date(from: dateString) {
        return date
      }

      throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
    }

    return decoder
  }
}
