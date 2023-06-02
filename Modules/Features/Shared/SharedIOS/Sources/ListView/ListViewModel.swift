import Core
import SwiftUI

public final class ListViewModel<Item: Identifiable>: ObservableObject, MainQueueUpdating {
  public typealias ContentValue = [Item]
  public typealias ContentState = ContentViewState<ContentValue>
  public typealias ContentStream = ContentViewStream<ContentValue>

  @MainActor
  @Published public var isLoading = false

  @MainActor
  @Published public var contentViewState = ContentViewState<ContentValue>.idle

  @MainActor
  @Published public var navigationTitle: String?

  @MainActor
  @Published public var sectionTitle: String?

  private let onItemSelection: (Item.ID) -> Void
  private let contentLoader: () -> ContentStream
  private var contentLoadingTask: Task<(), Never>?

  public init(
    screenTitle: String? = nil,
    sectionTitle: String? = nil,
    shouldCancelTasksOnDisappear _: Bool = true,
    contentLoader: @escaping () -> ContentStream,
    onItemSelection: @escaping (Item.ID) -> Void
  ) {
    self.contentLoader = contentLoader
    self.onItemSelection = onItemSelection
    mainQueueUpdate(\.sectionTitle, with: sectionTitle)
    mainQueueUpdate(\.navigationTitle, with: screenTitle)
  }

  public func didAppear() {
    contentLoadingTask?.cancel()

    contentLoadingTask = Task.detached(priority: .userInitiated) { [weak self] in
      guard let self else { return }
      for await status in contentLoader() {
        if status.isLoading {
          startLoading()
        } else {
          mainQueueUpdate(\.contentViewState, with: status)
          stopLoading()
        }
      }
    }
  }

  public func didDisappear() {
    contentLoadingTask?.cancel()
  }

  public func didSelect(id: Item.ID) {
    onItemSelection(id)
  }

  deinit {
    contentLoadingTask?.cancel()
  }

  private func startLoading() {
    mainQueueUpdate(\.isLoading, with: true)
  }

  private func stopLoading() {
    mainQueueUpdate(\.isLoading, with: false)
  }
}
