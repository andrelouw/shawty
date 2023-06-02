import SwiftUI
import UI

public struct ArtistView: View {
  public var body: some View {
    ZStack {
      Color.brand.secondary
        .ignoresSafeArea()
      VStack {
        Text(ArtistIOSStrings.welcomeMessage)
          .font(.headline)
          .foregroundColor(.font.primary)
        Text("Artist")
          .font(.largeTitle)
          .foregroundColor(.font.secondary)
      }
      .offset(y: -100)
    }
  }
}

struct ArtistView_Previews: PreviewProvider {
  static var previews: some View {
    ArtistView()
  }
}
