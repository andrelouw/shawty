import ArtistIOS
import SharedIOS
import Testing
import XCTest

protocol ArtistSearchScreen { }

extension ArtistSearchScreen where Self: UITestCase {
  func artistSearchNavigationBar(
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> XCUIElement {
    app.navigationBars[ArtistIOSStrings.artistSearchScreenTitle]
      .waitUntilExists(file: file, line: line)
  }

  func artistSearchField(
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> XCUIElement {
    artistSearchNavigationBar(
      file: file,
      line: line
    )
    .searchFields[ArtistIOSStrings.artistSearchPrompt]
    .waitUntilExists(file: file, line: line)
  }

  func noResultsTitle(
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> XCUIElement {
    app.staticTexts[SharedIOSStrings.noSearchTitle]
      .waitUntilExists(file: file, line: line)
  }
}
