import Foundation

extension Data {
  public static func anyValidJSONData() -> Data {
    Data("{}".utf8)
  }

  public static func invalidJSONData() -> Data {
    Data("invalid json".utf8)
  }

  public static func anyData() -> Data {
    Data()
  }
}
