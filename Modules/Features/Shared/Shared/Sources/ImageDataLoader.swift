import Foundation

public protocol ImageDataLoader {
  func load(with url: URL) async throws -> Data
}
