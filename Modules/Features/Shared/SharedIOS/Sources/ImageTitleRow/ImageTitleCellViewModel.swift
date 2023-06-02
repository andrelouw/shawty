import SwiftUI
import UI

public final class ImageTitleCellViewModel: ObservableObject {
  @MainActor
  @Published var loadingImage: LoadingImage = .empty

  @MainActor
  @Published var title: String?

  func didAppear() { }

  func didDisappear() { }
}
