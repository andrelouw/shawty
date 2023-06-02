import Foundation

public struct ImageTitleRowModel<ID: Hashable>: Identifiable {
  public let id: ID
  public let title: String
  public let imageURL: URL

  public init(
    id: ID,
    title: String,
    imageURL: URL
  ) {
    self.id = id
    self.title = title
    self.imageURL = imageURL
  }
}

extension ImageTitleRowModel: Equatable { }
