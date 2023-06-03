import Foundation

public struct Album: Equatable {
  public let id: Int
  public let title: String
  public let imageURL: URL
  public let releaseDate: Date
  public let hasExplicitLyrics: Bool

  public init(
    id: Int,
    title: String,
    imageURL: URL,
    releaseDate: Date,
    hasExplicitLyrics: Bool
  ) {
    self.id = id
    self.title = title
    self.imageURL = imageURL
    self.releaseDate = releaseDate
    self.hasExplicitLyrics = hasExplicitLyrics
  }
}
