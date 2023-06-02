import SwiftUI

public final class ListViewModel: ObservableObject {
  @MainActor
  @Published public var isLoading = false

  @MainActor
  @Published public var contentViewState = ContentViewState<[String]>.loaded(["TEsting"])

  @MainActor
  @Published public var navigationTitle: String?

  @MainActor
  @Published public var sectionTitle: String?

  public func didAppear() { }

  public func didDisappear() { }

  public func didSelect(id _: String) { }
}

// TODO: Remove, only temporary
extension String: Identifiable {
  public var id: String { self }
}
