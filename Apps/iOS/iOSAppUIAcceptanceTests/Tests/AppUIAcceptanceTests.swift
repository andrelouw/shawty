import SharedIOS
import Testing
import XCTest

final class AppUIAcceptanceTests: UITestCase {
  func test_appLaunch() {
    let noResultText = app.staticTexts[SharedIOSStrings.noSearchTitle].waitUntilExists()

    XCTAssertTrue(noResultText.exists)
  }
}
