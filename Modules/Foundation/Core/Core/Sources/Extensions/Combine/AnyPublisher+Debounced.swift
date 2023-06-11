import Combine
import Foundation

extension AnyPublisher where Output == String, Failure == Never {
  public func debounced(
    by time: DispatchQueue.SchedulerTimeType.Stride,
    on scheduler: DispatchQueue = .main
  ) -> Self {
    debounce(
      for: time,
      scheduler: scheduler
    )
    .eraseToAnyPublisher()
  }
}
