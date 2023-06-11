import Album
import Core
import Foundation
import UI
import UIIOS

extension Album {
  /// Transforms `Album` to `DetailHeaderModel`
  func asDetailHeaderModel() -> DetailHeaderModel {
    let dateString = DateFormatter.localeFullDayMonthYear().string(from: releaseDate)
    let icons = hasExplicitLyrics ? [Icon.explicit] : []

    return DetailHeaderModel(
      title: title,
      subtitle: AlbumIOSStrings.albumReleasedDate(dateString),
      icons: icons,
      imageURL: imageURL
    )
  }
}
