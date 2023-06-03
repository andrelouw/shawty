import Foundation
import Shared

extension FeatureFactory {
  public func albumTracksURL(forAlbumID id: Int) -> URL {
    AlbumEndpoint.tracks(id: id).url(baseURL: baseURL)
  }

  public func albumDetailURL(forAlbumID id: Int) -> URL {
    AlbumEndpoint.tracks(id: id).url(baseURL: baseURL)
  }
}
