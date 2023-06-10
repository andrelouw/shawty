import XCTest

final class AppUIAcceptanceTests: XCTestCase {
  func test_appLaunch() {
    let app = XCUIApplication()
    app.launch()
  }
}
