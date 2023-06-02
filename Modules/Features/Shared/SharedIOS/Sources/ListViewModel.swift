import SwiftUI

public final class ListViewModel<Item: Identifiable>: ObservableObject {
  public typealias ContentValue = [Item]

  @MainActor
  @Published public var isLoading = false

  @MainActor
  @Published public var contentViewState = ContentViewState<ContentValue>.idle

  @MainActor
  @Published public var navigationTitle: String?

  @MainActor
  @Published public var sectionTitle: String?

  public func didAppear() { }

  public func didDisappear() { }

  public func didSelect(id _: Item.ID) { }
}

// TODO: Remove, only temporary
extension String: Identifiable {
  public var id: String { self }
}
