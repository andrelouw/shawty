import SwiftUI

public struct Icon: Equatable {
  public let id: String
  let systemName: String?

  init(id: String, systemName: String? = nil) {
    self.id = id
    self.systemName = systemName
  }
}

extension Icon: Identifiable { }

extension Icon {
  public func asImage() -> Image {
    if let name = systemName {
      return Image(systemName: name)
    } else {
      return Image(systemName: "square.fill")
    }
  }
}
