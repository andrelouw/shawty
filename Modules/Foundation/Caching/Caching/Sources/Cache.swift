import Foundation

// https://www.swiftbysundell.com/articles/caching-in-swift/
final public class Cache<Key: Hashable, Value> {
  private let wrapped = NSCache<WrappedKey, Entry>()
  private let dateProvider: () -> Date
  private let cachePolicy: CachePolicy.Type

  public init(
    dateProvider: @escaping () -> Date = Date.init,
    cachePolicy: CachePolicy.Type,
    maximumEntryCount: Int = 50
  ) {
    self.dateProvider = dateProvider
    self.cachePolicy = cachePolicy
    wrapped.countLimit = maximumEntryCount
  }

  public func removeAll() {
    wrapped.removeAllObjects()
  }

  public func removeValue(forKey key: Key) {
    wrapped.removeObject(forKey: WrappedKey(key))
  }

  public func entry(forKey key: Key) -> Entry? {
    guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
      return nil
    }

    guard cachePolicy.validate(entry.timestamp, against: dateProvider()) else {
      removeValue(forKey: key)
      return nil
    }

    return entry
  }

  public func insert(_ value: Value, forKey key: Key) {
    let entry = Entry(key: key, value: value, timestamp: dateProvider())
    wrapped.setObject(entry, forKey: WrappedKey(entry.key))
  }
}

extension Cache {
  public final class WrappedKey: NSObject {
    let key: Key

    init(_ key: Key) { self.key = key }

    public override var hash: Int { key.hashValue }

    public override func isEqual(_ object: Any?) -> Bool {
      guard let value = object as? WrappedKey else {
        return false
      }

      return value.key == key
    }
  }
}

extension Cache {
  public final class Entry {
    let key: Key
    let value: Value
    let timestamp: Date

    init(key: Key, value: Value, timestamp: Date) {
      self.key = key
      self.value = value
      self.timestamp = timestamp
    }
  }
}
