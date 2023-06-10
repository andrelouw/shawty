import SharedIOS
import Testing
import XCTest

final class AppUIAcceptanceTests: UITestCase, ArtistSearchScreen, AlbumListScreen {
  func test_artistSearchHappyPath() {
    // Shows No results
    XCTAssertTrue(noResultsTitle().exists)

    // Search for artist
    let artistSearchField = artistSearchField()
    artistSearchField.tap()
    waitUntilElementHasFocus(element: artistSearchField).typeText("Kygo")

    // Tap on first result
    cell(withTitle: "Kygo").tap()

    XCTAssertTrue(cell(withTitle: "Thrill Of The Chase").exists)
  }
}
