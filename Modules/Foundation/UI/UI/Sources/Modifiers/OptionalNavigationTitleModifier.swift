#if os(iOS)
import SwiftUI

struct OptionalNavigationTitle: ViewModifier {
  let title: String?

  func body(content: Content) -> some View {
    if let title {
      content
        .navigationTitle(title)
    } else {
      content
        .toolbar(.hidden, for: .navigationBar)
    }
  }
}

extension View {
  public func optionalNavigationTitle(
    title: String?
  ) -> some View {
    modifier(
      OptionalNavigationTitle(
        title: title
      )
    )
  }
}
#endif
