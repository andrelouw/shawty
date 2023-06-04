import Foundation

extension Date {
  public func asISO8601FullDateString() -> String {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withFullDate]

    return formatter.string(from: self)
  }
}
