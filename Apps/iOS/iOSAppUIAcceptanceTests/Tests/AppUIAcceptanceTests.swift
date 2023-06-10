import SharedIOS
import Testing
import XCTest

final class AppUIAcceptanceTests: UITestCase, ArtistSearchScreen {
  func test_onLaunch_artistSearchShowsNoSearchActiveNotice() {
    XCTAssertTrue(noResultsTitle().exists)
  }
}
