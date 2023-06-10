import XCTest

extension XCUIElement {
  @discardableResult
  public func waitUntilExists(
    timeout: TimeInterval = 5,
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> XCUIElement {
    let elementExists = waitForExistence(timeout: timeout)
    if elementExists {
      return self
    } else {
      XCTFail("Could not find \(self)", file: file, line: line)
    }

    return self
  }

  public var hasFocus: Bool { value(forKey: "hasKeyboardFocus") as? Bool ?? false }
}
