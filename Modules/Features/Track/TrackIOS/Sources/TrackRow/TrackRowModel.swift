public struct TrackRowModel<ID: Hashable>: Identifiable {
  public let id: ID
  public let title: String

  public init(
    id: ID,
    title: String
  ) {
    self.id = id
    self.title = title
  }
}

extension TrackRowModel: Equatable { }
