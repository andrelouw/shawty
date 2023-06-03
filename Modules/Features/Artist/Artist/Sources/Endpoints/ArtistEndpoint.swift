import Foundation

public enum ArtistEndpoint {
  case search
  case albums(id: Int)

  public func url(baseURL: URL) -> URL {
    switch self {
    case .search:
      return baseURL.appending(path: "search/artist")
    case .albums(let id):
      return baseURL.appending(path: "artist/\(id)/albums")
    }
  }
}
