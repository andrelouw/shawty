import Foundation

public final class LocalImageDataLoader: ImageDataLoader {
  private let store: ImageDataStore

  public init(store: ImageDataStore) {
    self.store = store
  }

  public func save(_ data: Data, for url: URL) async throws {
    do {
      try await store.insert(data, for: url)
    } catch {
      throw ImageDataStoreError.save(.failed(error))
    }
  }

  public func load(_ url: URL) async throws -> Data {
    do {
      let data = try await store.retrieve(dataForURL: url)
      guard let data else {
        throw ImageDataStoreError.load(.notFound)
      }
      return data
    } catch let error as ImageDataStoreError {
      throw error
    } catch {
      throw ImageDataStoreError.load(.failed(error))
    }
  }
}
