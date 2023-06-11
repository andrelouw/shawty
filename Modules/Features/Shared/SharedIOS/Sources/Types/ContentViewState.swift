import UIIOS

public enum ContentViewState<Content> {
  case loading
  case idle
  case screenNotice(ScreenNoticeModel)
  case loaded(Content)
  case error(String)

  public static var empty: Self {
    ContentViewState.screenNotice(.noResults)
  }

  public static var noSearch: Self {
    ContentViewState.screenNotice(.noSearch)
  }

  public var isLoading: Bool {
    if case .loading = self {
      return true
    }

    return false
  }
}
