import Core
import SwiftUI
import UI

public final class ImageTitleRowViewModel<ID: Hashable>: ObservableObject, Identifiable, MainQueueUpdating {
  public typealias ImageLoader = (URL) -> AsyncStream<LoadingImage>

  @MainActor
  @Published public var loadingImage: LoadingImage = .empty

  @MainActor
  @Published public var title: String?

  private var imageLoadingTask: Task<(), Never>?
  private let imageLoader: ImageLoader
  private let model: ImageTitleRowModel<ID>
  public var id: ID { model.id }

  public init(
    model: ImageTitleRowModel<ID>,
    imageLoader: @escaping ImageLoader
  ) {
    self.model = model
    self.imageLoader = imageLoader
  }

  func didAppear() {
    mainQueueUpdate(\.title, with: model.title)
    loadImage()
  }

  func didDisappear() {
    imageLoadingTask?.cancel()
  }

  private func loadImage() {
    imageLoadingTask?.cancel()
    imageLoadingTask = Task.detached(priority: .userInitiated) { [weak self] in
      guard let self else { return }
      for await status in imageLoader(model.imageURL) {
        mainQueueUpdate(\.loadingImage, with: status)
      }
    }
  }
}
