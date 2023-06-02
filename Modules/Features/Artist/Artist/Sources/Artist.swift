import Foundation

public struct Artist: Equatable {
  public let id: Int
  public let name: String
  public let imageURL: URL

  public init(id: Int, name: String, imageURL: URL) {
    self.id = id
    self.name = name
    self.imageURL = imageURL
  }
}
