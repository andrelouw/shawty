import SwiftUI

extension View {
  public func fadeOnTransition() -> some View {
    transition(.opacity.animation(.easeInOut(duration: 0.35)))
      .zIndex(1)
  }
}
