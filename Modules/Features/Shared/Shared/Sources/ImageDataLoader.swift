import Foundation

public protocol ImageDataLoader {
  func loadImageData(from url: URL) async throws -> Data
}
