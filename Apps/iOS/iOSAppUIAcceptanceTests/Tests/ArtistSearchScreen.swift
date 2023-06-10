import ArtistIOS
import SharedIOS
import Testing
import XCTest

protocol ArtistSearchScreen { }

extension ArtistSearchScreen where Self: UITestCase {
  func noResultsTitle(
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> XCUIElement {
    app.staticTexts[SharedIOSStrings.noSearchTitle]
      .waitUntilExists(file: file, line: line)
  }
}
