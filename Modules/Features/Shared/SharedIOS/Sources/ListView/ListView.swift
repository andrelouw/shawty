import SwiftUI
import UI

public protocol ListRowDisplayable: View {
  associatedtype Item: Identifiable
}

public struct ListView<Row: ListRowDisplayable>: View {
  public typealias ViewModel = ListViewModel<Row.Item>
  public typealias RowView = (Row.Item) -> Row

  @StateObject private var viewModel: ViewModel

  private let rowView: RowView

  public init(
    viewModel: ViewModel,
    rowView: @escaping RowView
  ) {
    _viewModel = StateObject(wrappedValue: viewModel)
    self.rowView = rowView
  }

  public var body: some View {
    ZStack {
      Color.background.primary.ignoresSafeArea()
      contentView
      loader
    }
    .onViewDidLoad {
      viewModel.didAppear()
    }
    .onDisappear {
      viewModel.didDisappear()
    }
    .optionalNavigationTitle(title: viewModel.navigationTitle)
    .navigationBarTitleDisplayMode(.large)
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
    case .idle:
      EmptyView()
    case .screenNotice(let model):
      screenNoticeView(model: model)
        .fadeOnTransition()
    case .error(let message):
      errorView(with: message)
    case .loaded(let viewModels):
      listView(with: viewModels)
    default:
      screenNoticeView(model: .idle)
    }
  }

  private func listView(with items: [Row.Item]) -> some View {
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
    .background(Color.background.primary)
  }

  private func cells(for items: [Row.Item]) -> some View {
    ForEach(items) { item in
      rowView(item)
        .contentShape(Rectangle())
        .onTapGesture {
          viewModel.didSelect(id: item.id)
        }.listRowBackground(Color.background.primary)
    }
  }

  private func screenNoticeView(model: ScreenNoticeModel) -> some View {
    ScreenNoticeView(model: model)
  }

  private func errorView(with message: String) -> some View {
    ScreenNoticeView(model: .error(message: message))
  }
}
