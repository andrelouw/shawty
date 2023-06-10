import Foundation

public final class ImageDataLoaderCacheDecorator: ImageDataLoader {
  private let imageDataLoader: any ImageDataLoader
  private let cache: ImageDataStore

  public init(
    imageDataLoader: any ImageDataLoader,
    cache: ImageDataStore
  ) {
    self.imageDataLoader = imageDataLoader
    self.cache = cache
  }

  public func load(_ input: URL) async throws -> Data {
    let data = try await imageDataLoader.load(input)
    try? await cache.insert(data, for: input)
    return data
  }
}
