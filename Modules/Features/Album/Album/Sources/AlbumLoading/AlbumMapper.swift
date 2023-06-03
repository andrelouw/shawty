import Foundation
import Networking

internal enum AlbumMapper {
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

  static func map(_ data: Data, _ response: HTTPURLResponse) throws -> Album {
    guard response.isOK else {
      throw RemoteAlbumLoader.Error.invalidData(.statusCode(response.statusCode))
    }

    do {
      let decoder = JSONDecoder.default
      return try decoder.decode(Item.self, from: data).album
    } catch let error as DecodingError {
      throw RemoteAlbumLoader.Error.invalidData(.decoding(error))
    } catch {
      throw RemoteAlbumLoader.Error.invalidData(.unknown(error))
    }
  }
}
