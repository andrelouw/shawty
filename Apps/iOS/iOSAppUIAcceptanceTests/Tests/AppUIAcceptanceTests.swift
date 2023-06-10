import SharedIOS
import XCTest

final class AppUIAcceptanceTests: XCTestCase {
  func test_appLaunch() {
    let app = XCUIApplication()
    app.launch()

    XCTAssertTrue(app.staticTexts[SharedIOSStrings.noSearchTitle].exists)
  }
}
