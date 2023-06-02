public protocol MainQueueUpdating {
  func mainQueueUpdate<Value>(
    _ keyPath: ReferenceWritableKeyPath<Self, Value>,
    with value: Value
  ) async
}

extension MainQueueUpdating {
  public func mainQueueUpdate<Value>(
    _ keyPath: ReferenceWritableKeyPath<Self, Value>,
    with value: Value
  ) {
    Task(priority: .userInitiated) {
      await MainActor.run {
        self[keyPath: keyPath] = value
      }
    }
  }
}
