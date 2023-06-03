import Album
import Core
import SharedIOS
import SwiftUI
import UI

public final class AlbumDetailViewModel: ObservableObject, MainQueueUpdating {
  public typealias DetailLoader = () async -> DetailHeaderModel?
  public typealias ImageLoader = (URL) -> AsyncStream<LoadingImage>

  @MainActor
  @Published public var headerModel: DetailHeaderModel?

  @MainActor
  @Published public var headerLoadingImage = LoadingImage.empty

  private let detailLoader: DetailLoader
  private var detailLoadingTask: Task<DetailHeaderModel?, Never>?
  private var imageLoadingTask: Task<(), Never>?
  private let imageLoader: ImageLoader

  public init(
    detailLoader: @escaping DetailLoader,
    imageLoader: @escaping ImageLoader
  ) {
    self.detailLoader = detailLoader
    self.imageLoader = imageLoader
  }

  public func didAppear() {
    Task {
      await loadAlbumDetail()
    }
  }

  public func didDisappear() {
    detailLoadingTask?.cancel()
    imageLoadingTask?.cancel()
  }

  private func loadAlbumDetail() async {
    detailLoadingTask?.cancel()

    mainQueueUpdate(\.headerLoadingImage, with: .loading)
    detailLoadingTask = Task.detached(priority: .userInitiated) { [weak self] in
      guard let self else { return nil }
      return await detailLoader()
    }

    let detail = try? await detailLoadingTask?.result.get()
    mainQueueUpdate(\.headerModel, with: detail)

    guard let detail else { return }

    imageLoadingTask?.cancel()
    imageLoadingTask = Task.detached(priority: .userInitiated) { [weak self] in
      guard let self else { return }
      for await status in imageLoader(detail.imageURL) {
        mainQueueUpdate(\.headerLoadingImage, with: status)
      }
    }
  }
}
