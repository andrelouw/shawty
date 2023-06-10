import XCTest

extension XCTestCase {
  @discardableResult
  public func waitUntilElementHasFocus(
    element: XCUIElement,
    timeout: TimeInterval = 5,
    file _: StaticString = #filePath,
    line _: UInt = #line
  ) -> XCUIElement {
    let expectation = expectation(description: "waiting for element \(element) to have focus")

    let timer = Timer(timeInterval: 1, repeats: true) { timer in
      guard element.hasFocus else { return }

      expectation.fulfill()
      timer.invalidate()
    }

    RunLoop.current.add(timer, forMode: .common)

    wait(for: [expectation], timeout: timeout)

    return element
  }
}
