import XCTest

open class UITestCase: XCTestCase {
  // swiftlint:disable:next implicitly_unwrapped_optional
  public var app: XCUIApplication!

  open override func setUp() {
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
  }

  public func cell(
    withTitle title: String,
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> XCUIElement {
    app.collectionViews.cells.staticTexts[title]
      .waitUntilExists(file: file, line: line)
  }
}
