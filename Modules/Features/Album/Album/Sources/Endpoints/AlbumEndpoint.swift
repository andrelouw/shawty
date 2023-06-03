import Foundation

public enum AlbumEndpoint {
  case tracks(id: Int)
  case album(id: Int)

  public func url(baseURL: URL) -> URL {
    switch self {
    case .tracks(let id):
      return baseURL.appending(path: "album/\(id)/tracks")
    case .album(let id):
      return baseURL.appending(path: "album/\(id)")
    }
  }
}
