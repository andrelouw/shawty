import Networking

extension RemoteLoadingError: Equatable {
  public static func == (lhs: RemoteLoadingError, rhs: RemoteLoadingError) -> Bool {
    switch (lhs, rhs) {
    case (.connectivity, .connectivity),
         (.invalidData(.decoding(.valueNotFound)), .invalidData(.decoding(.valueNotFound))),
         (.invalidData(.decoding(.dataCorrupted)), .invalidData(.decoding(.dataCorrupted))),
         (.invalidData(.decoding(.typeMismatch)), .invalidData(.decoding(.typeMismatch))),
         (.invalidData(.decoding(.keyNotFound)), .invalidData(.decoding(.keyNotFound))),
         (.invalidData(.unknown), .invalidData(.unknown)):
      return true
    case (.invalidData(.statusCode(let A)), .invalidData(.statusCode(let B))):
      return A == B
    default:
      return false
    }
  }
}
