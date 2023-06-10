import Testing
import UI
import XCTest

extension UITestCase {
  func icon(
    _ icon: Icon,
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> XCUIElement {
    app.images[icon.id]
      .waitUntilExists(file: file, line: line)
  }
}
