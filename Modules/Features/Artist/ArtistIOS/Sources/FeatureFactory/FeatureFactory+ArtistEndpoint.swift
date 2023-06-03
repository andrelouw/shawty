import Artist
import Foundation
import Shared

extension FeatureFactory {
  public func artistAlbumsURL(forArtistID id: Int) -> URL {
    ArtistEndpoint.albums(id: id).url(baseURL: baseURL)
  }
}
