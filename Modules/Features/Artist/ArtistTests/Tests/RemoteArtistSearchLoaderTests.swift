import Artist
import Core
import Networking
import NetworkTesting
import Testing
import XCTest

final class RemoteArtistSearchLoaderTests: XCTestCase {
  func test_init_doesNotRequestDataFromURL() async throws {
    let (_, client) = makeSUT()

    XCTAssertEqual(client.requestedURLs, [])
  }

  func test_load_requestsDataFromURL_whenSearchQueryNotEmpty() async throws {
    let search = makeSearchFixture()
    let (sut, client) = makeSUT(url: search.baseURL)

    try await expect(
      requestedURLs: [search.urlWithQuery],
      on: client,
      when: {
        _ = try await timedOutLoad(with: search.queryString, for: sut)
      }
    )
  }

  func test_loadTwice_requestsDataFromURLTwice_whenSearchQueriesNotEmpty() async throws {
    let search = makeSearchFixture()
    let (sut, client) = makeSUT(url: search.baseURL)

    try await expect(
      requestedURLs: [search.urlWithQuery, search.urlWithQuery],
      on: client,
      when: {
        _ = try? await timedOutLoad(with: search.queryString, for: sut)
        _ = try? await timedOutLoad(with: search.queryString, for: sut)
      }
    )
  }

  func test_load_doesNotRequestDataFromURL_whenSearchQueryEmpty() async throws {
    let (sut, client) = makeSUT()

    try await expect(
      requestedURLs: [],
      on: client,
      when: {
        _ = try? await timedOutLoad(with: "", for: sut)
      }
    )
  }

  func test_load_addsSearchQueryToURLAsQueryParameter() async throws {
    let search = makeSearchFixture()
    let (sut, client) = makeSUT(url: search.baseURL)
    client.complete(withStatusCode: 200, data: anyValidJSONData(), for: search.urlWithQuery)

    _ = try await sut.load(with: search.queryString)

    let requestedURL = try XCTUnwrap(client.requestedURLs.first)
    XCTAssertEqual(requestedURL, search.urlWithQuery)
  }

  func test_load_deliversErrorOnClientError() async throws {
    let (sut, client) = makeSUT()

    try await expect(
      sut,
      with: anySearchQuery,
      toCompleteWith: .failure(.connectivity),
      when: {
        client.complete(withError: .anyNSError())
      }
    )
  }

  func test_load_deliversInvalidDataErrorOnNon200HTTPResponse() async throws {
    let statusCodes = [199, 201, 300, 400, 500]

    try await statusCodes.asyncForEach { code in
      let search = makeSearchFixture()
      let (sut, client) = makeSUT(url: search.baseURL)

      try await expect(
        sut,
        with: search.queryString,
        toCompleteWith: .failure(.invalidData(.statusCode(code))),
        when: {
          client.complete(withStatusCode: code, data: anyValidJSONData(), for: search.urlWithQuery)
        }
      )
    }
  }

  func test_load_deliversInvalidDataErrorOn200HTTPResponseWithInvalidJSON() async throws {
    let search = makeSearchFixture()
    let (sut, client) = makeSUT(url: search.baseURL)

    // TODO: Clean up dirty data below (.dataCorrupted)
    try await expect(
      sut,
      with: search.queryString,
      toCompleteWith: .failure(.invalidData(.decoding(.dataCorrupted(.init(codingPath: [], debugDescription: ""))))),
      when: {
        client.complete(withStatusCode: 200, data: invalidJSONData(), for: search.urlWithQuery)
      }
    )
  }

  func test_load_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() async throws {
    let search = makeSearchFixture()
    let (sut, client) = makeSUT(url: search.baseURL)

    try await expect(
      sut,
      with: search.queryString,
      toCompleteWith: .success([]),
      when: {
        client.complete(withStatusCode: 200, data: emptyListJSONData(), for: search.urlWithQuery)
      }
    )
  }

  func test_load_deliversArtistsOn200HTTPResponseWithJSONItems() async throws {
    let search = makeSearchFixture()
    let (sut, client) = makeSUT(url: search.baseURL)

    let artist1 = makeArtist(id: 0, name: "Some name", imageURL: .anyURL())
    let artist2 = makeArtist(id: 1, name: "Another name", imageURL: .anyURL())
    let artists = [artist1.entity, artist2.entity]
    let json = makeArtistJSON([artist1.json, artist2.json])

    try await expect(
      sut,
      with: search.queryString,
      toCompleteWith: .success(artists),
      when: {
        client.complete(withStatusCode: 200, data: json, for: search.urlWithQuery)
      }
    )
  }

  // TODO: Figure out how to do this one
  func test_load_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() throws {
    throw XCTSkip("Skipping due to complexity and lack of knowledge on how to do this in async/await ATM")
  }
}

// MARK: - Helpers

extension RemoteArtistSearchLoaderTests {
  private typealias Entity = Artist
  private typealias SUT = RemoteArtistSearchLoader
  private typealias LoadResult = Result<[Entity], SUT.Error>

  private func makeSUT(
    url: URL = .anyURL(),
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> (sut: SUT, client: HTTPClientSpy) {
    let client = HTTPClientSpy()
    let sut = SUT(url: url, client: client)

    expectNoMemoryLeaks(for: sut, file: file, line: line)
    expectNoMemoryLeaks(for: client, file: file, line: line)

    return (sut, client)
  }

  // MARK: Assertion Helpers

  private func expect(
    requestedURLs urls: [URL],
    on client: HTTPClientSpy,
    file: StaticString = #filePath,
    line: UInt = #line,
    when action: () async throws -> Void
  ) async throws {
    do {
      try await action()
      XCTAssertEqual(client.requestedURLs, urls, file: file, line: line)
    } catch let error as TimeoutError {
      return XCTFail(error.localizedDescription, file: file, line: line)
    } catch is SUT.Error {
      // Ignoring Loader errors for this expectation, only checking requested urls
      return
    } catch {
      XCTFail("Expected action to succeed, but failed with error: \(error)", file: file, line: line)
    }
  }

  private func expect(
    _ sut: SUT,
    with searchQuery: String,
    toCompleteWith expectedResult: LoadResult,
    when action: () -> Void,
    file: StaticString = #filePath,
    line: UInt = #line
  ) async throws {
    action()

    do {
      let result = try await timedOutLoad(with: searchQuery, for: sut)
      expect(result, toMatch: expectedResult, file: file, line: line)
    } catch let error as TimeoutError {
      return XCTFail(error.localizedDescription, file: file, line: line)
    } catch let receivedError {
      expect(receivedError, toMatch: expectedResult, file: file, line: line)
    }
  }

  private func expect(
    _ result: [Entity],
    toMatch expectedResult: LoadResult,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    if case .failure(let error) = expectedResult {
      return XCTFail("Expected load() to fail with error: \(error)", file: file, line: line)
    }

    do {
      let successResults = try expectedResult.get()
      XCTAssertEqual(result, successResults, file: file, line: line)
    } catch {
      return XCTFail("Expected load() to succeed with artists: \(result)", file: file, line: line)
    }
  }

  private func expect(
    _ error: Error,
    toMatch expectedResult: LoadResult,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    switch expectedResult {
    case .success(let artists):
      return XCTFail(
        "Expected load() to succeed with artists: \(artists)",
        file: file,
        line: line
      )

    case .failure(let expectedError):
      guard let error = error as? SUT.Error else {
        return XCTFail(
          "Expected error of type RemoteArtistSearchLoader.Error",
          file: file,
          line: line
        )
      }

      XCTAssertEqual(error, expectedError, file: file, line: line)
    }
  }

  // MARK: Timeout Loader Helper

  private func timedOutLoad(
    with query: String,
    for sut: SUT,
    timeout seconds: TimeInterval = 2
  ) async throws -> [Entity] {
    // FIXME: The `unowned sut` is a weird one. The timeout task is holding onto sut for some reason
    try await timeoutTask(timeout: seconds) { [unowned sut] in
      try await sut.load(with: query)
    }
  }
}

// MARK: - Fixtures

extension RemoteArtistSearchLoaderTests {
  private struct SearchFixture {
    let baseURL: URL
    let urlWithQuery: URL
    let queryString: String
  }

  // MARK: Search

  private func makeSearchFixture(
    url: URL = .anyURL(),
    searchQuery: String = .anySearchQuery
  ) -> SearchFixture {
    let urlWithSearchQuery = URL(string: "\(url.absoluteString)?q=\(searchQuery)")!

    return SearchFixture(
      baseURL: url,
      urlWithQuery: urlWithSearchQuery,
      queryString: searchQuery
    )
  }

  private var anySearchQuery: String { .anySearchQuery }

  // MARK: Artist

  private func makeArtist(id: Int, name: String, imageURL: URL) -> (entity: Entity, json: [String: Any]) {
    let artist = Entity(id: id, name: name, imageURL: imageURL)
    var json = [String: Any]()
    json["id"] = artist.id
    json["name"] = artist.name
    json["picture_small"] = artist.imageURL.absoluteString

    return (artist, json)
  }

  // MARK: JSON Data

  private func anyValidJSONData() -> Data {
    makeArtistJSON(
      [
        makeArtist(id: 0, name: "Kygo", imageURL: .anyURL()).json,
      ]
    )
  }

  private func invalidJSONData() -> Data {
    .invalidJSONData()
  }

  private func emptyListJSONData() -> Data {
    makeArtistJSON([])
  }

  private func makeArtistJSON(_ artists: [[String: Any]]) -> Data {
    let json = ["data": artists]
    return try! JSONSerialization.data(withJSONObject: json)
  }
}

// MARK: - String Extensions

// swiftformat:disable:next extensionAccessControl
private extension String {
  // swiftformat:disable:next extensionAccessControl
  static let anySearchQuery = "Kygo"
}
