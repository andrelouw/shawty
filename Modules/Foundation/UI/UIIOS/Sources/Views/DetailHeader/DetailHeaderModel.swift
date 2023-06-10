import Foundation
import UI

public struct DetailHeaderModel: Equatable {
  public let title: String
  public let subtitle: String
  public let icons: [Icon]
  public let imageURL: URL

  public init(title: String, subtitle: String, icons: [Icon], imageURL: URL) {
    self.title = title
    self.subtitle = subtitle
    self.icons = icons
    self.imageURL = imageURL
  }
}
