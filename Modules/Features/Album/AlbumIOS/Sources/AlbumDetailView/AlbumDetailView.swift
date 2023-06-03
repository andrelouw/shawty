import Album
import SharedIOS
import SwiftUI
import Track
import TrackIOS
import UI

public struct AlbumDetailView<ContentView: View>: View {
  @ObservedObject var viewModel: AlbumDetailViewModel
  private var contentView: () -> ContentView

  public init(
    viewModel: AlbumDetailViewModel,
    contentView: @escaping () -> ContentView
  ) {
    self.viewModel = viewModel
    self.contentView = contentView
  }

  public var body: some View {
    VStack(spacing: 20) {
      header
        .frame(height: 100)
      contentView()
    }
    .onViewDidLoad {
      viewModel.didAppear()
    }
    .onDisappear {
      viewModel.didDisappear()
    }
    .edgesIgnoringSafeArea(.bottom)
  }

  private var header: some View {
    ZStack(alignment: .top) {
      headerBackground
      headerContent
    }
  }

  @ViewBuilder private var headerBackground: some View {
    GeometryReader { geometry in
      LoadingImageView(loadingImage: viewModel.headerLoadingImage)
        .blur(radius: 2)
        .overlay {
          Color.black.opacity(0.5)
        }
        .edgesIgnoringSafeArea(.top)
        .frame(
          maxWidth: geometry.size.width,
          maxHeight: geometry.size.height
        )
    }
  }

  @ViewBuilder private var headerContent: some View {
    if let model = viewModel.headerModel {
      DetailHeaderView(
        model: model
      )
    }
  }
}
