import SwiftUI
import UI

public struct SharedView: View {
  public var body: some View {
    ZStack {
      Color.brand.secondary
        .ignoresSafeArea()
      VStack {
        Text(SharedIOSStrings.welcomeMessage)
          .font(.headline)
          .foregroundColor(.font.primary)
        Text("Shared")
          .font(.largeTitle)
          .foregroundColor(.font.secondary)
      }
      .offset(y: -100)
    }
  }
}

struct SharedView_Previews: PreviewProvider {
  static var previews: some View {
    SharedView()
  }
}
