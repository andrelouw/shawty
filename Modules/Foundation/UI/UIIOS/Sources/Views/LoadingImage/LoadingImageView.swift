import SwiftUI
import UI

public struct LoadingImageView: View {
  private var loadingImage: LoadingImage

  public init(
    loadingImage: LoadingImage
  ) {
    self.loadingImage = loadingImage
  }

  public var body: some View {
    ZStack {
      switch loadingImage {
      case .loaded:
        imageView
          .fadeOnTransition()
      case .loading:
        loaderView
          .fadeOnTransition()
      case .empty:
        placeholderView
          .fadeOnTransition()
      }
    }
  }

  @ViewBuilder private var placeholderView: some View {
    Color.background.secondary
  }

  @ViewBuilder private var loaderView: some View {
    RoundedRectangle(cornerRadius: 5)
      .foregroundColor(Color.black.opacity(0.15))
      .shimmering()
  }

  @ViewBuilder private var imageView: some View {
    if let image = loadingImage.image {
      Image(uiImage: image)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .clipped()
    } else {
      Image(systemName: "photo")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.brand.secondary)
    }
  }
}
