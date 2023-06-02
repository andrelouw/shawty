import SwiftUI

public struct Icon: Equatable {
  public let id: String
  let systemName: String?
  let iconName: String?

  init(id: String, systemName: String? = nil, iconName: String? = nil) {
    self.id = id
    self.systemName = systemName
    self.iconName = iconName
  }
}

extension Icon: Identifiable { }

extension Icon {
  public func asSystemImage() -> Image {
    if let name = systemName {
      return Image(systemName: name)
    } else {
      return Image(systemName: "square.fill")
    }
  }

  public func asImage() -> Image {
    if let name = iconName {
      return Image(name)
    } else {
      return Image(systemName: "square.fill")
    }
  }
}
