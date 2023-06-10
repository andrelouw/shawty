import Foundation
import Shared
import UIIOS

/// Adapts `ImageDataLoading` output to an `AsyncStream` of `LoadingImage`
public struct ImageDataLoadingImageAdapter: QueryValueLoader {
  private let imageDataLoader: any ImageDataLoader
  private let dataImageAdapter: DataImageTransformer

  public init(
    imageDataLoader: any ImageDataLoader,
    dataImageAdapter: @escaping DataImageTransformer
  ) {
    self.imageDataLoader = imageDataLoader
    self.dataImageAdapter = dataImageAdapter
  }

  public func load(_ url: URL) -> AsyncStream<LoadingImage> {
    AsyncStream { continuation in
      continuation.yield(.loading)
      Task {
        do {
          let imageData = try await imageDataLoader.load(url)
          let image = dataImageAdapter(imageData)
          continuation.yield(.loaded(image))
        } catch {
          continuation.yield(.loaded(nil))
        }
        continuation.finish()
      }
    }
  }
}
