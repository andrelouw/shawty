import Album
import Core
import Networking
import NetworkTesting
import Testing
import XCTest

final class RemoteAlbumLoaderTests: XCTestCase {
  func test_init_doesNotRequestDataFromURL() async throws {
    let (_, client) = makeSUT()

    XCTAssertEqual(client.requestedURLs, [])
  }

  func test_load_requestsDataFromURL() async throws {
    let url = anyURL()
    let (sut, client) = makeSUT(url: url)

    try await expect(
      requestedURLs: [url],
      on: client,
      when: {
        _ = try? await timedOutLoad(for: sut)
      }
    )
  }

  func test_loadTwice_requestsDataFromURLTwice() async throws {
    let url = anyURL()
    let (sut, client) = makeSUT(url: url)

    try await expect(
      requestedURLs: [url, url],
      on: client,
      when: {
        _ = try? await timedOutLoad(for: sut)
        _ = try? await timedOutLoad(for: sut)
      }
    )
  }

  func test_load_deliversErrorOnClientError() async throws {
    let (sut, client) = makeSUT()

    try await expect(
      sut,
      toCompleteWith: .failure(.connectivity),
      when: {
        client.complete(withError: .anyNSError())
      }
    )
  }

  func test_load_deliversInvalidDataErrorOnNon200HTTPResponse() async throws {
    let statusCodes = [199, 201, 300, 400, 500]

    try await statusCodes.asyncForEach { code in
      let url = anyURL()
      let (sut, client) = makeSUT(url: url)

      try await expect(
        sut,
        toCompleteWith: .failure(.invalidData(.statusCode(code))),
        when: {
          client.complete(withStatusCode: code, data: anyValidJSONData(), for: url)
        }
      )
    }
  }

  func test_load_deliversInvalidDataErrorOn200HTTPResponseWithInvalidJSON() async throws {
    let url = anyURL()
    let (sut, client) = makeSUT(url: url)

    try await expect(
      sut,
      toCompleteWith: .failure(.invalidData(.decoding(.anyDataCorruptedError()))),
      when: {
        client.complete(withStatusCode: 200, data: invalidJSONData(), for: url)
      }
    )
  }

  func test_load_deliversArtistsOn200HTTPResponseWithJSONItems() async throws {
    let url = anyURL()
    let (sut, client) = makeSUT(url: url)

    let album = makeAlbum(
      id: 0,
      title: "Some title",
      imageURL: .anyURL(),
      releaseDate: .distantPast,
      hasExplicitLyrics: true
    )
    let json = makeAlbumJSON(album.json)

    try await expect(
      sut,
      toCompleteWith: .success(album.entity),
      when: {
        client.complete(withStatusCode: 200, data: json, for: url)
      }
    )
  }

  // TODO: Figure out how to do this one
  func test_load_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() throws {
    throw XCTSkip("Skipping due to complexity and lack of knowledge on how to do this in async/await ATM")
  }
}

// MARK: - Helpers

extension RemoteAlbumLoaderTests {
  private typealias Entity = Album
  private typealias SUT = RemoteAlbumLoader
  private typealias LoadResult = Result<Entity, SUT.Error>

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
    toCompleteWith expectedResult: LoadResult,
    when action: () -> Void,
    file: StaticString = #filePath,
    line: UInt = #line
  ) async throws {
    action()

    do {
      let result = try await timedOutLoad(for: sut)
      expect(result, toMatch: expectedResult, file: file, line: line)
    } catch let error as TimeoutError {
      return XCTFail(error.localizedDescription, file: file, line: line)
    } catch let receivedError {
      expect(receivedError, toMatch: expectedResult, file: file, line: line)
    }
  }

  private func expect(
    _ result: Entity,
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
      return XCTFail("Expected load() to succeed but got error: \(error)", file: file, line: line)
    }
  }

  private func expect(
    _ error: Error,
    toMatch expectedResult: LoadResult,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    switch expectedResult {
    case .success:
      return XCTFail(
        "Expected load() to succeed but got error: \(error)",
        file: file,
        line: line
      )

    case .failure(let expectedError):
      guard let error = error as? SUT.Error else {
        return XCTFail(
          "Expected error of type RemoteAlbumLoader.Error",
          file: file,
          line: line
        )
      }

      XCTAssertEqual(error, expectedError, file: file, line: line)
    }
  }

  // MARK: Timeout Loader Helper

  private func timedOutLoad(
    for sut: SUT,
    timeout seconds: TimeInterval = 2
  ) async throws -> Entity {
    try await timeoutTask(timeout: seconds) { [unowned sut] in
      try await sut.load()
    }
  }
}

// MARK: - Fixtures

extension RemoteAlbumLoaderTests {
  // MARK: Album

  private func makeAlbum(
    id: Int,
    title: String,
    imageURL: URL,
    releaseDate: Date,
    hasExplicitLyrics: Bool
  ) -> (entity: Entity, json: [String: Any]) {
    let album = Entity(
      id: id,
      title: title,
      imageURL: imageURL,
      releaseDate: releaseDate,
      hasExplicitLyrics: hasExplicitLyrics
    )

    var json = [String: Any]()
    json["id"] = album.id
    json["title"] = album.title
    json["cover_big"] = album.imageURL.absoluteString
    json["release_date"] = album.releaseDate.asISO8601FullDateString()
    json["explicit_lyrics"] = album.hasExplicitLyrics

    return (album, json)
  }

  // MARK: - URL

  private func anyURL() -> URL {
    .anyURL()
  }

  // MARK: JSON Data

  private func anyValidJSONData() -> Data {
    makeAlbumJSON(
      makeAlbum(
        id: 0,
        title: "Thrill Of The Chase",
        imageURL: .anyURL(),
        releaseDate: .distantPast,
        hasExplicitLyrics: true
      ).json
    )
  }

  private func invalidJSONData() -> Data {
    .invalidJSONData()
  }

  private func makeAlbumJSON(_ album: [String: Any]) -> Data {
    try! JSONSerialization.data(withJSONObject: album)
  }
}
