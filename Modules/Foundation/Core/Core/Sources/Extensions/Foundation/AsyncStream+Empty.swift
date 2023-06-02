import Foundation

extension AsyncStream {
  public static var empty: Self {
    Self {
      $0.finish()
    }
  }
}
