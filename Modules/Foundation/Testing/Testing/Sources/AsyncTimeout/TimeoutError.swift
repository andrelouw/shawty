import Foundation

public struct TimeoutError: LocalizedError {
  public var errorDescription: String? {
    "The operation timed out."
  }
}
