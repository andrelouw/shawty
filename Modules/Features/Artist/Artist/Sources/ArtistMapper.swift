import Foundation
import Networking

internal enum ArtistsMapper {
  private struct Root: Decodable {
    let data: FailableDecodableArray<Item>
  }

  private struct Item: Decodable {
    let id: Int
    let name: String
    let pictureSmall: URL

    var artist: Artist {
      Artist(
        id: id,
        name: name,
        imageURL: pictureSmall
      )
    }
  }

  static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [Artist] {
    guard response.isOK else {
      throw RemoteArtistSearchLoader.Error.invalidData(.statusCode(response.statusCode))
    }

    do {
      let decoder = JSONDecoder.default
      let root = try decoder.decode(Root.self, from: data)
      return root.data.elements.compactMap { $0.artist }
    } catch let error as DecodingError {
      throw RemoteArtistSearchLoader.Error.invalidData(.decoding(error))
    } catch {
      throw RemoteArtistSearchLoader.Error.invalidData(.unknown(error))
    }
  }
}
