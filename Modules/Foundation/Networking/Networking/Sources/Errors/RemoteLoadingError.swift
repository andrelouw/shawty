public enum RemoteLoadingError: Error {
  case connectivity
  case invalidData(InvalidDataError)

  public enum InvalidDataError: Error {
    case statusCode(Int)
    case decoding(DecodingError)
    case unknown(Error)
  }
}
