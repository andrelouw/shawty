import ArtistIOS
import SharedIOS
import Testing
import UI
import XCTest

final class AppUIAcceptanceTests: UITestCase {
  func test_artistSearchHappyPath() {
    expect(screenNotice: .noSearch)

    // Search for artist
    search(withQuery: "Kygo")

    // Tap on first artist
    cell(withTitle: "Kygo").tap()

    // Tap on first album
    cell(withTitle: "Thrill Of The Chase").tap()

    // Tap on first track
    cell(withTitle: "Gone Are The Days (feat. James Gillespie)").tap()

    // Tap on alert
    alert(withTitle: "'Playing' Track")
      .button(withTitle: "OK")
      .tap()

    // Navigate back to Search Screen
    navigationBarBackButton().tap()
    navigationBarBackButton().tap()

    // Cancel search
    button(withTitle: "Cancel").tap()
    expect(screenNotice: .noSearch)
  }

  func test_artistSearchNoResultsFound() {
    expect(screenNotice: .noSearch)

    search(withQuery: "FFFFFFFFFFFFFFFFFFFFFFFFFFFFF")

    expect(screenNotice: .noResults)
  }

  // MARK: - Helpers

  private func expect(
    screenNotice: ScreenNoticeModel,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    expect(text(withTitle: screenNotice.title), file: file, line: line)
    if let subtitle = screenNotice.subtitle {
      expect(text(withTitle: subtitle), file: file, line: line)
    }
    expect(icon(screenNotice.icon), file: file, line: line)
  }

  private func search(
    withQuery query: String,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    let artistSearchField = searchField(
      withTitle: ArtistIOSStrings.artistSearchPrompt,
      file: file,
      line: line
    )

    artistSearchField.tap()

    waitUntilElementHasFocus(
      element: artistSearchField,
      file: file,
      line: line
    )
    .typeText(query)
  }
}
