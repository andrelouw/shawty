import UI

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
      iconColor: .red
    )
  }

  public static var noResults: ScreenNoticeModel {
    ScreenNoticeModel(
      title: SharedIOSStrings.noSearchTitle,
      subtitle: SharedIOSStrings.noSearchSubtitle,
      icon: .noResults
    )
  }

  public static var noSearch: ScreenNoticeModel {
    ScreenNoticeModel(
      title: SharedIOSStrings.noSearchTitle,
      subtitle: SharedIOSStrings.noSearchSubtitle,
      icon: .search,
      iconColor: .brand.primary
    )
  }
}
