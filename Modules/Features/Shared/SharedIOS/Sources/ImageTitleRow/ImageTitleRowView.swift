import SwiftUI
import UI

struct ImageTitleRowView<ID: Hashable>: View, ListRowDisplayable {
  typealias Item = ImageTitleRowViewModel<ID>

  @StateObject private var viewModel: Item

  public init(viewModel: Item) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }

  var body: some View {
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
    // TODO: Move foreground color to UI module
    Icon.chevron.asSystemImage()
      .font(.footnote.bold())
      .foregroundColor(Color(UIColor.tertiaryLabel))
      .padding(.leading)
  }

  @ViewBuilder private var imageView: some View {
    LoadingImageView(loadingImage: viewModel.loadingImage)
      .frame(width: 50, height: 50)
      .clipped()
      .clipShape(RoundedRectangle(cornerRadius: 5))
  }
}
