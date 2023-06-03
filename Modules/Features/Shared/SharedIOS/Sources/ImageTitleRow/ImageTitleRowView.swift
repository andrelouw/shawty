import SwiftUI
import UI

public struct ImageTitleRowView<ID: Hashable>: View, ListRowDisplayable {
  public typealias Item = ImageTitleRowViewModel<ID>

  @StateObject private var viewModel: Item

  public init(viewModel: Item) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }

  public var body: some View {
    HStack {
      imageView
      if let title = viewModel.title {
        Text(title)
          .foregroundColor(Color.font.primary)
      }
      Spacer()
      rowChevronIcon
    }
    .onAppear {
      viewModel.didAppear()
    }
    .onDisappear {
      viewModel.didDisappear()
    }
  }

  private var rowChevronIcon: some View {
    Icon.chevron.asImage()
      .font(.footnote.bold())
      .foregroundColor(.font.secondary)
      .padding(.leading)
  }

  @ViewBuilder private var imageView: some View {
    LoadingImageView(loadingImage: viewModel.loadingImage)
      .frame(width: 50, height: 50)
      .clipped()
      .clipShape(RoundedRectangle(cornerRadius: 5))
  }
}
