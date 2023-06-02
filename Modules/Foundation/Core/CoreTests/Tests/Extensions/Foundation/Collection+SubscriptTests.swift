//

import XCTest

final class Collection_SubscriptTests: XCTestCase {
  func test_safe_returnsValueAtIndex_whenValueFound() {
    let array = [1, 2, 3]

    XCTAssertEqual(array[safe: 1], 2)
  }

  func test_safe_returnsNil_whenNoValueFoundAtIndex() {
    let array = [1, 2, 3]

    XCTAssertNil(array[safe: 4])
  }
}
