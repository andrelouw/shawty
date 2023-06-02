public protocol ArtistSearchLoader {
  func load(with query: String) async throws -> [Artist]
}
