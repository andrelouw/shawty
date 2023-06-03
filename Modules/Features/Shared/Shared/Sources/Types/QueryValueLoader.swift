public protocol QueryValueLoader {
  associatedtype Output
  associatedtype Input
  func load(_ input: Input) async throws -> Output
}
