import Foundation

public protocol ImageDataStore {
  typealias Error = ImageDataStoreError

  func insert(_ data: Data, for url: URL) async throws
  func retrieve(dataForURL url: URL) async throws -> Data?
}
