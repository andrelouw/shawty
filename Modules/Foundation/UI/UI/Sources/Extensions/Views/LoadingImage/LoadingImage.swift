#if canImport(UIKit)
import UIKit

public enum LoadingImage: Equatable {
  case loaded(UIImage?)
  case loading
  case empty

  public var isLoading: Bool {
    if case .loading = self {
      return true
    }
    return false
  }

  public var image: UIImage? {
    if case .loaded(let image) = self {
      return image
    }
    return nil
  }
}
#endif
