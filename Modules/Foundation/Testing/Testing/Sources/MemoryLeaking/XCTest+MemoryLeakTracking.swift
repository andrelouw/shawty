import XCTest

extension XCTestCase {
  internal func trackForMemoryLeaks(
    _ instance: AnyObject,
    expectFailure: Bool,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    addTeardownBlock { [weak instance] in
      XCTExpectFailure("Expected a memory leak", enabled: expectFailure)
      XCTAssertNil(
        instance,
        "Instance should have been deallocated. Potential memory leak.",
        file: file,
        line: line
      )
    }
  }

  public func expectNoMemoryLeaks(
    for instance: AnyObject,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    trackForMemoryLeaks(
      instance,
      expectFailure: false,
      file: file,
      line: line
    )
  }
}
