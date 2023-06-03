import SwiftUI

// Reference: https://sarunw.com/posts/swiftui-viewdidload/
struct ViewDidLoadModifier: ViewModifier {
  @State private var viewDidLoad = false
  let action: (() -> Void)?

  func body(content: Content) -> some View {
    content
      .onAppear {
        if viewDidLoad == false {
          viewDidLoad = true
          action?()
        }
      }
  }
}

extension View {
  public func onViewDidLoad(perform action: (() -> Void)? = nil) -> some View {
    modifier(ViewDidLoadModifier(action: action))
  }
}
