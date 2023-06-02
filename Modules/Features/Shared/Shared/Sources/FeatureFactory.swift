import Foundation
import Networking

public protocol FeatureFactory {
  var baseURL: URL { get }
  var httpClient: HTTPClient { get }
  var imageLoader: any ImageDataLoader { get }
}
