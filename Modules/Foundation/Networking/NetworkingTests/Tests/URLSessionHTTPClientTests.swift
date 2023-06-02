import Foundation
import Networking
import NetworkTesting
import Testing
import XCTest

final class URLSessionHTTPClientTests: XCTestCase {
  override func setUp() {
    super.setUp()
    URLProtocolStub.startInterceptingRequests()
  }

  override func tearDown() {
    super.tearDown()
    URLProtocolStub.stopInterceptingRequests()
  }

  func test_get_performsGETRequestWithURL() async throws {
    let url = anyURL()
    let sut = makeSUT()

    _ = try? await sut.get(from: url)

    let request = try XCTUnwrap(URLProtocolStub.lastRequest)
    XCTAssertEqual(request.url, url)
    XCTAssertEqual(request.httpMethod, "GET")
  }

  func test_get_failsOnRequestError() async throws {
    let stubError = anyNSError()
    let sut = makeSUT()
    URLProtocolStub.stub(data: nil, response: nil, error: stubError)

    do {
      _ = try await sut.get(from: .anyURL())
      XCTFail("Expected get to fail with error")
    } catch let error as NSError {
      XCTAssertEqual(error.domain, stubError.domain)
      XCTAssertEqual(error.code, stubError.code)
    } catch {
      XCTFail("Expected error to be of type NSError")
    }
  }

  func test_get_succeedsOnHTTPURLResponseWithData() async throws {
    let url = anyURL()
    let stubData = anyData()
    let stubResponse = anyHTTPURLResponse(with: url)
    let sut = makeSUT()
    URLProtocolStub.stub(data: stubData, response: stubResponse, error: nil)

    let (data, response) = try await sut.get(from: url)

    XCTAssertEqual(data, stubData)
    XCTAssertEqual(response.url, stubResponse.url)
    XCTAssertEqual(response.statusCode, stubResponse.statusCode)
  }

  func test_get_succeedsWithEmptyDataOnHTTPURLResponseWithNilData() async throws {
    let url = anyURL()
    let stubResponse = anyHTTPURLResponse(with: url)
    let sut = makeSUT()
    URLProtocolStub.stub(data: nil, response: stubResponse, error: nil)

    let (data, response) = try await sut.get(from: url)

    XCTAssertEqual(data, Data())
    XCTAssertEqual(response.url, stubResponse.url)
    XCTAssertEqual(response.statusCode, stubResponse.statusCode)
  }

  func test_get_failsOnInvalidResponseType() async throws {
    let stubResponse = noneHTTPURLResponse()
    let sut = makeSUT()
    URLProtocolStub.stub(data: nil, response: stubResponse, error: nil)

    do {
      _ = try await sut.get(from: .anyURL())
      XCTFail("Expected failure with error `unexpectedResponseType`")
    } catch URLSessionHTTPClient.Error.unexpectedResponseType {
      return
    } catch {
      XCTFail("Expected failure with error `unexpectedResponseType`")
    }
  }

  func test_get_failsOnRequestError_whenDataAndResponseIsValid() async throws {
    let stubError = anyNSError()
    let stubResponse = anyHTTPURLResponse()
    let sut = makeSUT()
    URLProtocolStub.stub(data: anyData(), response: stubResponse, error: stubError)

    do {
      _ = try await sut.get(from: .anyURL())
      XCTFail("Expected failure with error")
    } catch {
      return
    }
  }

  // MARK: - Helpers
  private func makeSUT(
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> HTTPClient {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [URLProtocolStub.self]
    let session = URLSession.shared

    let sut = URLSessionHTTPClient(session: session)
    expectNoMemoryLeaks(for: sut, file: file, line: line)
    return sut
  }

  // MARK: URLProtocol Stub

  private class URLProtocolStub: URLProtocol {
    private static var stub: Stub?
    static var lastRequest: URLRequest?

    private struct Stub {
      let data: Data?
      let response: URLResponse?
      let error: Error?
    }

    static func startInterceptingRequests() {
      URLProtocol.registerClass(URLProtocolStub.self)
    }

    static func stopInterceptingRequests() {
      URLProtocol.unregisterClass(URLProtocolStub.self)
      stub = nil
    }

    static func stub(data: Data?, response: URLResponse?, error: Error?) {
      stub = Stub(data: data, response: response, error: error)
    }

    override class func canInit(with _: URLRequest) -> Bool {
      true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
      request
    }

    override func startLoading() {
      guard let client else {
        fatalError("Client missing")
      }

      Self.lastRequest = request

      if let data = URLProtocolStub.stub?.data {
        client.urlProtocol(self, didLoad: data)
      }

      if let response = URLProtocolStub.stub?.response {
        client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
      } else {
        // This callback is required for `URLProtocol` otherwise it crashes with vague error
        client.urlProtocol(self, didReceive: URLResponse(), cacheStoragePolicy: .notAllowed)
      }

      if let error = URLProtocolStub.stub?.error {
        client.urlProtocol(self, didFailWithError: error)
      }

      client.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() { }
  }
}

// MARK: Fixtures

extension URLSessionHTTPClientTests {
  private func anyNSError() -> NSError {
    NSError(domain: "any error", code: 1)
  }

  private func anyURL() -> URL {
    .anyURL()
  }

  private func anyData() -> Data {
    Data("any data".utf8)
  }

  private func noneHTTPURLResponse(with url: URL = .anyURL()) -> URLResponse {
    URLResponse(
      url: url,
      mimeType: nil,
      expectedContentLength: 0,
      textEncodingName: nil
    )
  }

  private func anyHTTPURLResponse(with url: URL = .anyURL(), statusCode: Int = 203) -> HTTPURLResponse {
    .response(for: url, withStatusCode: statusCode)
  }
}
