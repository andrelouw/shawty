import UI

public enum ContentViewState<Content> {
  case loading
  case screenNotice(ScreenNoticeModel)
  case loaded(Content)
  case error(String)
}
