public protocol ValueLoader {
  associatedtype Output
  func load() async throws -> Output
}
