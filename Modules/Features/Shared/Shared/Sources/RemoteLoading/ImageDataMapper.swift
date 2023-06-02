import Foundation

internal enum ImageDataMapper {
  static func map(_ data: Data, _ response: HTTPURLResponse) throws -> Data {
    guard response.isOK else {
      throw RemoteImageDataLoader.Error.invalidData(.statusCode(response.statusCode))
    }

    guard !data.isEmpty else {
      throw RemoteImageDataLoader.Error.invalidData(
        .decoding(
          .dataCorrupted(
            .init(codingPath: [], debugDescription: "Data is empty")
          )
        )
      )
    }

    return data
  }
}
