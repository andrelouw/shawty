#if os(iOS)
import SwiftUI

struct OptionalNavigationTitle: ViewModifier {
  let title: String?
  let displayMode: NavigationBarItem.TitleDisplayMode

  func body(content: Content) -> some View {
    if let title {
      content
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(displayMode)
    } else {
      content
        .toolbar(.hidden, for: .navigationBar)
    }
  }
}

extension View {
  public func optionalNavigationTitle(
    title: String?,
    displayMode: NavigationBarItem.TitleDisplayMode = .automatic
  ) -> some View {
    modifier(
      OptionalNavigationTitle(
        title: title,
        displayMode: displayMode
      )
    )
  }
}
#endif
