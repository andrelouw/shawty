import SwiftUI
import UI

public struct ListView<RowView: View>: View {
  @ObservedObject private var viewModel: ListViewModel

  private let rowView: (String) -> RowView

  init(
    viewModel: ListViewModel,
    rowView: @escaping (String) -> RowView
  ) {
    self.viewModel = viewModel
    self.rowView = rowView
  }

  public var body: some View {
    NavigationView {
      ZStack {
        contentView
        loader
      }
    }
    .onViewDidLoad {
      viewModel.didAppear()
    }
    .onDisappear {
      viewModel.didDisappear()
    }
    // This position is important has to be after life cycles
    .optionalNavigationTitle(title: viewModel.navigationTitle, displayMode: .large)
  }

  @ViewBuilder private var loader: some View {
    if viewModel.isLoading {
      VStack {
        Spacer()
        AnimatingLoaderView().padding()
      }
      .transition(.opacity.animation(.easeInOut(duration: 0.35)))
      .zIndex(1)
    }
  }

  @ViewBuilder private var contentView: some View {
    switch viewModel.contentViewState {
    case .screenNotice(let model):
      screenNoticeView(model: model)
    case .error(let message):
      errorView(with: message)
    case .loaded(let viewModels):
      listView(with: viewModels)
    default:
      screenNoticeView(model: .idle)
    }
  }

  private func listView(with items: [String]) -> some View {
    List {
      if let sectionTitle = viewModel.sectionTitle {
        Section(sectionTitle) {
          cells(for: items)
        }
      } else {
        cells(for: items)
      }
    }
    .scrollContentBackground(.hidden)
    .listStyle(.grouped)
  }

  private func cells(for items: [String]) -> some View {
    ForEach(items) { item in
      rowView(item)
        .contentShape(Rectangle())
        .onTapGesture {
          viewModel.didSelect(id: item)
        }
    }
  }

  private func screenNoticeView(model: ScreenNoticeModel) -> some View {
    ScreenNoticeView(model: model)
      .offset(y: -50)
  }

  private func errorView(with message: String) -> some View {
    ScreenNoticeView(model: .error(message: message))
      .offset(y: -50)
  }
}

struct ListView_Previews: PreviewProvider {
  static var previews: some View {
    ListView(
      viewModel: ListViewModel()
    ) {
      Text($0)
    }
  }
}
