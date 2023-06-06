import Caching
import Foundation

public final class ImageDataCacheStore: ImageDataStore {
  private lazy var imageDataCache = Cache<URL, Data>(cachePolicy: ImageDataCachePolicy.self)

  public init() { }

  public func insert(_ data: Data, for url: URL) async throws {
    imageDataCache.insert(data, for: url)
  }

  public func retrieve(dataForURL url: URL) async throws -> Data? {
    imageDataCache.value(for: url)
  }

  private enum ImageDataCachePolicy: CachePolicy {
    private static let calendar = Calendar(identifier: .gregorian)

    private static var maxCacheAgeInDays: Int {
      1
    }

    static func validate(_ timestamp: Date, against date: Date) -> Bool {
      guard let maxCacheAge = calendar.date(byAdding: .day, value: maxCacheAgeInDays, to: timestamp) else {
        return false
      }
      return date < maxCacheAge
    }
  }
}
