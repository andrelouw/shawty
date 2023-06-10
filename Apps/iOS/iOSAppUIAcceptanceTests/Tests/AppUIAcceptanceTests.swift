import SharedIOS
import Testing
import XCTest

final class AppUIAcceptanceTests: XCTestCase {
  func test_appLaunch() {
    let app = XCUIApplication()
    app.launch()
    let noResultText = app.staticTexts[SharedIOSStrings.noSearchTitle].waitUntilExists()

    XCTAssertTrue(noResultText.exists)
  }
}
