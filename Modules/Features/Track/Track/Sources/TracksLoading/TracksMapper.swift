import Foundation
import Networking

internal enum TracksMapper {
  private struct Root: Decodable {
    let data: FailableDecodableArray<Item>
  }

  private struct Item: Decodable {
    let id: Int
    let title: String

    var track: Track {
      Track(
        id: id,
        title: title
      )
    }
  }

  static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [Track] {
    guard response.isOK else {
      throw RemoteTracksLoader.Error.invalidData(.statusCode(response.statusCode))
    }

    do {
      let decoder = JSONDecoder.default
      let root = try decoder.decode(Root.self, from: data)
      return root.data.elements.compactMap { $0.track }
    } catch let error as DecodingError {
      throw RemoteTracksLoader.Error.invalidData(.decoding(error))
    } catch {
      throw RemoteTracksLoader.Error.invalidData(.unknown(error))
    }
  }
}
