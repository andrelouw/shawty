import UI
import UIIOS

extension ScreenNoticeModel {
  public static let idle = ScreenNoticeModel(
    title: SharedIOSStrings.appName,
    subtitle: SharedIOSStrings.appTagLine,
    icon: .headphones,
    iconColor: .brand.primary,
    style: .watermark
  )

  public static func error(message: String? = nil) -> ScreenNoticeModel {
    ScreenNoticeModel(
      title: SharedIOSStrings.genericErrorTitle,
      subtitle: message,
      icon: .error,
      iconColor: .status.error
    )
  }

  public static var noResults: ScreenNoticeModel {
    ScreenNoticeModel(
      title: SharedIOSStrings.noResultsTitle,
      subtitle: SharedIOSStrings.noResultsSubtitle,
      icon: .noResults,
      iconColor: .status.warning
    )
  }

  public static var noSearch: ScreenNoticeModel {
    ScreenNoticeModel(
      title: SharedIOSStrings.noSearchTitle,
      subtitle: SharedIOSStrings.noSearchSubtitle,
      icon: .search,
      iconColor: .brand.secondary
    )
  }
}
