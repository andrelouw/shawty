extension DecodingError {
  public static func anyDataCorruptedError() -> DecodingError {
    .dataCorrupted(.init(codingPath: [], debugDescription: ""))
  }
}
