import Foundation

public final class ImageDataLoaderWithFallbackComposite: ImageDataLoader {
  private let primary: any ImageDataLoader
  private let fallback: any ImageDataLoader

  public init(
    primary: any ImageDataLoader,
    fallback: any ImageDataLoader
  ) {
    self.primary = primary
    self.fallback = fallback
  }

  public func load(_ input: URL) async throws -> Data {
    do {
      return try await primary.load(input)
    } catch {
      return try await fallback.load(input)
    }
  }
}
