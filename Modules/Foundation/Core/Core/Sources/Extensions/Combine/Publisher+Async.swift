import Combine

// Reference: https://augmentedcode.io/2023/01/09/async-await-support-for-combines-sink-and-map/
extension Publisher where Self.Failure == Never {
  public func sink(receiveValue: @escaping ((Self.Output) async -> Void)) -> AnyCancellable {
    sink { value in
      Task {
        await receiveValue(value)
      }
    }
  }
}
