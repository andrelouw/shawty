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

    // Tap on first artist
    cell(withTitle: "Kygo").tap()

    // Tap on first album
    cell(withTitle: "Thrill Of The Chase").tap()

    // Shows track results
    XCTAssertTrue(cell(withTitle: "Gone Are The Days (feat. James Gillespie)").exists)
  }
}
