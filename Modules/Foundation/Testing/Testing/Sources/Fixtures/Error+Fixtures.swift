import Foundation

extension Error where Self == NSError {
  public static func anyNSError() -> Error {
    NSError(domain: "Test", code: 0)
  }
}
