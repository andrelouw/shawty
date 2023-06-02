import Foundation

public protocol ImageDataLoader: QueryValueLoader where Input == URL, Output == Data { }
