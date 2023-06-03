import SwiftUI

public struct DetailHeaderView: View {
  private var model: DetailHeaderModel

  public init(model: DetailHeaderModel) {
    self.model = model
  }

  public var body: some View {
    VStack(spacing: 0) {
      title
      Spacer()
        .frame(height: 16)
      HStack {
        subtitle
        Spacer()
        icons
      }
    }
    .padding()
  }

  private var title: some View {
    Text(model.title)
      .font(.title2)
      .foregroundColor(.font.onOverlay)
      .lineLimit(2)
      .padding()
  }

  private var subtitle: some View {
    Text(model.subtitle)
      .font(.subheadline)
      .foregroundColor(.font.onOverlay)
  }

  private var icons: some View {
    HStack {
      ForEach(model.icons) {
        $0.asSystemImage()
          .foregroundColor(.font.onOverlay)
      }
    }
  }
}

struct AlbumDetailHeaderView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color.black
      DetailHeaderView(
        model: DetailHeaderModel(
          title: "Title",
          subtitle: "Subtitle",
          icons: [.explicit],
          imageURL: URL(string: "http://www.google.com")!
        )
      ).border(Color.white)
    }
    .frame(maxWidth: .infinity)
  }
}
