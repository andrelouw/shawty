// Reference: https://www.swiftbysundell.com/articles/async-and-concurrent-forEach-and-map/
extension Sequence {
  // TODO: Missing tests
  public func asyncForEach(
    _ operation: (Element) async throws -> Void
  ) async rethrows {
    for element in self {
      try await operation(element)
    }
  }
}
