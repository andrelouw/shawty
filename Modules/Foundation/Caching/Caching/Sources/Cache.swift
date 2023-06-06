import Foundation

// https://www.swiftbysundell.com/articles/caching-in-swift/
final public class Cache<Key: Hashable, Value> {
  private let wrapped = NSCache<WrappedKey, Entry>()
  private let dateProvider: () -> Date
  private let entryLifetime: TimeInterval
  private let keyTracker = KeyTracker()

  public init(
    dateProvider: @escaping () -> Date = Date.init,
    entryLifetime: TimeInterval = 12 * 60 * 60,
    maximumEntryCount: Int = 50
  ) {
    self.dateProvider = dateProvider
    self.entryLifetime = entryLifetime
    wrapped.countLimit = maximumEntryCount
    wrapped.delegate = keyTracker
  }

  public func removeValue(forKey key: Key) {
    wrapped.removeObject(forKey: WrappedKey(key))
  }

  public func entry(forKey key: Key) -> Entry? {
    guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
      return nil
    }

    guard dateProvider() < entry.expirationDate else {
      removeValue(forKey: key)
      return nil
    }

    return entry
  }

  public func insert(_ entry: Entry) {
    wrapped.setObject(entry, forKey: WrappedKey(entry.key))
    keyTracker.keys.insert(entry.key)
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
    let expirationDate: Date

    private init(key: Key, value: Value, expirationDate: Date) {
      self.key = key
      self.value = value
      self.expirationDate = expirationDate
    }
  }
}

extension Cache {
  final class KeyTracker: NSObject, NSCacheDelegate {
    var keys = Set<Key>()

    func cache(
      _: NSCache<AnyObject, AnyObject>,
      willEvictObject object: Any
    ) {
      guard let entry = object as? Entry else {
        return
      }

      keys.remove(entry.key)
    }
  }
}
