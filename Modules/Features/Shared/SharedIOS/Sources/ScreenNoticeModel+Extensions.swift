import UI

extension ScreenNoticeModel {
  public static let idle = ScreenNoticeModel(
    title: "Shawty",
    subtitle: "...like a melody in my head",
    icon: .headphones,
    iconColor: .brand.primary,
    style: .watermark
  )

  public static func error(message: String? = nil) -> ScreenNoticeModel {
    ScreenNoticeModel(
      title: "Oops!\nI did it again",
      subtitle: message,
      icon: .error,
      iconColor: .red
    )
  }

  public static var noResults: ScreenNoticeModel {
    ScreenNoticeModel(
      title: "Still haven't found \nwhat you're looking for?",
      subtitle: "Search for an artist",
      icon: .noResults
    )
  }

  public static var noSearch: ScreenNoticeModel {
    ScreenNoticeModel(
      title: "I've got a blank space, baby...",
      subtitle: "Try a different search term?",
      icon: .search,
      iconColor: .brand.primary
    )
  }
}
