public protocol QueryValueLoader {
  associatedtype Output
  associatedtype Input
  func load(with input: Input) async throws -> Output
}
