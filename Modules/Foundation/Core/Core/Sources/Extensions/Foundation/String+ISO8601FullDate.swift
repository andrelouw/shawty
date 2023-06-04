import Foundation

extension String {
  public func asISO8601FullDate() -> Date? {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withFullDate]

    return formatter.date(from: self)
  }
}
