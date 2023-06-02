import Foundation

public enum ArtistEndpoint {
  case search

  public func url(baseURL: URL) -> URL {
    switch self {
    case .search:
      return baseURL.appending(path: "search/artist")
    }
  }
}
