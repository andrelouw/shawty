import SharedIOS
import Testing
import XCTest

final class AppUIAcceptanceTests: UITestCase, ArtistSearchScreen {
  func test_onLaunch_artistSearchShowsNoSearchActiveNotice() {
    XCTAssertTrue(noResultsTitle().exists)
  }

  func test_artistSearch_displaysResults() {
    let artistSearchField = artistSearchField()
    artistSearchField.tap()
    waitUntilElementHasFocus(element: artistSearchField).typeText("Kygo")

    XCTAssertTrue(artistCell(withTitle: "Kygo").exists)
  }
}
