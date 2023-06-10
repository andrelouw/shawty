import SwiftUI
import UI

// Reference: https://betterprogramming.pub/create-an-awesome-loading-state-using-swiftui-9815ff6abb80
public struct AnimatingLoaderView: View {
  private var color: Color = .brand.secondary
  private var diameter: CGFloat = 10

  public init() { }

  @State private var animating = false

  public var body: some View {
    HStack {
      animatingCircle()
      animatingCircle(withDelay: 0.3)
      animatingCircle(withDelay: 0.6)
    }
    .onAppear {
      withAnimation {
        animating = true
      }
    }
  }

  private func animatingCircle(withDelay duration: Double = 0) -> some View {
    Circle()
      .fill(color)
      .frame(width: diameter, height: diameter)
      .scaleEffect(animating ? 1.0 : 0.5)
      .animation(
        .easeInOut(duration: 0.5)
          .repeatForever()
          .delay(duration),
        value: animating
      )
  }
}

struct AnimatingLoaderView_Previews: PreviewProvider {
  static var previews: some View {
    AnimatingLoaderView()
  }
}
