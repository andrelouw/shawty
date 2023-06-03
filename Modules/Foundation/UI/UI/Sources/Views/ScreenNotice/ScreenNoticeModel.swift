import SwiftUI

public struct ScreenNoticeModel: Equatable {
  public enum Style {
    case prominent
    case watermark

    var opacity: Double {
      if case .watermark = self {
        return 0.3
      }
      return 1.0
    }
  }

  public let title: String
  public let subtitle: String?
  public let icon: Icon
  public let iconColor: Color
  public let style: Style

  public init(
    title: String,
    subtitle: String? = nil,
    icon: Icon,
    iconColor: Color = .brand.primary,
    style: Style = .prominent
  ) {
    self.title = title
    self.subtitle = subtitle
    self.icon = icon
    self.iconColor = iconColor
    self.style = style
  }
}
