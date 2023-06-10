import SharedIOS
import Testing
import XCTest

final class AppUIAcceptanceTests: UITestCase, ArtistSearchScreen {
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

    // Tap on frist track
    cell(withTitle: "Gone Are The Days (feat. James Gillespie)").tap()

    alert(withTitle: "'Playing' Track")
      .button(withTitle: "OK")
      .tap()
  }
}
