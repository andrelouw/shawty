import Foundation

public protocol CachePolicy {
  static func validate(_ timestamp: Date, against date: Date) -> Bool
}
