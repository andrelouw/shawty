import Networking
import Shared

// The Live instance of the Feature Factory, providing the live global instances
final class LiveFeatureFactory: FeatureFactory {
  private init() { }

  fileprivate static let shared = LiveFeatureFactory()

  lazy var httpClient: HTTPClient = URLSessionHTTPClient(session: .shared)

  lazy var imageLoader: any ImageDataLoader = imageDataLoaderWithCache
  let baseURL = Config.baseURL

  private lazy var imageDataCacheStore: ImageDataStore = ImageDataCacheStore()
  private lazy var localImageDataLoader: any ImageDataLoader = LocalImageDataLoader(store: imageDataCacheStore)
  private lazy var remoteImageDataLoader: any ImageDataLoader = RemoteImageDataLoader(
    client: httpClient
  )
  private lazy var imageDataLoaderWithCache = ImageDataLoaderWithFallbackComposite(
    primary: localImageDataLoader,
    fallback: ImageDataLoaderCacheDecorator(
      imageDataLoader: remoteImageDataLoader,
      cache: imageDataCacheStore
    )
  )
}

extension FeatureFactory where Self == LiveFeatureFactory {
  static var live: Self { .shared }
}
