import SwiftUI
import UI

public struct TrackView: View {
  public var body: some View {
    ZStack {
      Color.brand.secondary
        .ignoresSafeArea()
      VStack {
        Text(TrackIOSStrings.welcomeMessage)
          .font(.headline)
          .foregroundColor(.font.primary)
        Text("Track")
          .font(.largeTitle)
          .foregroundColor(.font.secondary)
      }
      .offset(y: -100)
    }
  }
}

struct TrackView_Previews: PreviewProvider {
  static var previews: some View {
    TrackView()
  }
}
