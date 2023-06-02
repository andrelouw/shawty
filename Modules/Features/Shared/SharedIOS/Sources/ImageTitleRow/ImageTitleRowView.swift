import SwiftUI
import UI

struct ImageTitleRowView: View {
  var title: String
  var loadingImage: LoadingImage

  var body: some View {
    HStack {
      imageView
      Text(title)
      Spacer()
      rowChevronIcon
    }
  }

  private var rowChevronIcon: some View {
    // TODO: Move foreground color to UI module
    Icon.chevron.asSystemImage()
      .font(.footnote.bold())
      .foregroundColor(Color(UIColor.tertiaryLabel))
      .padding(.leading)
  }

  @ViewBuilder private var imageView: some View {
    LoadingImageView(loadingImage: loadingImage)
      .frame(width: 50, height: 50)
      .clipped()
      .clipShape(RoundedRectangle(cornerRadius: 5))
  }
}

struct ImageTitleRowView_Previews: PreviewProvider {
  static var previews: some View {
    ImageTitleRowView(
      title: "Title",
      loadingImage: .loading
    )
    .background(Color.background.primary)
  }
}
