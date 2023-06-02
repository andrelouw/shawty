import SwiftUI
import UI

public final class ImageTitleCellViewModel<ID: Hashable>: ObservableObject, Identifiable {
  @MainActor
  @Published public var loadingImage: LoadingImage = .empty

  @MainActor
  @Published public var title: String?

  public var id: ID { model.id }

  private let model: ImageTitleCellModel<ID>

  init(model: ImageTitleCellModel<ID>) {
    self.model = model
  }

  func didAppear() { }

  func didDisappear() { }
}
