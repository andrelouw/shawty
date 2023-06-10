import XCTest

open class UITestCase: XCTestCase {
  // swiftlint:disable:next implicitly_unwrapped_optional
  public var app: XCUIApplication!

  open override func setUp() {
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
  }
}
