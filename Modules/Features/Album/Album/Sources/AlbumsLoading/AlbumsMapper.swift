import Foundation
import Networking

internal enum AlbumsMapper {
  private struct Root: Decodable {
    let data: FailableDecodableArray<Item>
  }

  private struct Item: Decodable {
    let id: Int
    let title: String
    let coverBig: URL
    let releaseDate: Date
    let explicitLyrics: Bool

    var album: Album {
      Album(
        id: id,
        title: title,
        imageURL: coverBig,
        releaseDate: releaseDate,
        hasExplicitLyrics: explicitLyrics
      )
    }
  }

  static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [Album] {
    guard response.isOK else {
      throw RemoteAlbumsLoader.Error.invalidData(.statusCode(response.statusCode))
    }

    do {
      let decoder = JSONDecoder.default
      let root = try decoder.decode(Root.self, from: data)
      return root.data.elements.compactMap { $0.album }
    } catch let error as DecodingError {
      throw RemoteAlbumsLoader.Error.invalidData(.decoding(error))
    } catch {
      throw RemoteAlbumsLoader.Error.invalidData(.unknown(error))
    }
  }
}
