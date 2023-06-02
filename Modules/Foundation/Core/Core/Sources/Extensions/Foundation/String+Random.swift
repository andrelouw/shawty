extension String {
  // Reference: https://stackoverflow.com/a/26845710/5826424
  public static func random(withLength length: Int = 10) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map { _ in letters.randomElement()! })
  }
}
