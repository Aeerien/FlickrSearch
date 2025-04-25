//  FlickrPhotoServiceTests.swift
//  FlickrSearchTests
//  Created by Irina Arkhireeva on 25.04.2025.

import XCTest
@testable import FlickrSearch

final class MockURLProtocol: URLProtocol {
    static var testData: Data?
    static var response: URLResponse?
    static var error: Error?

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        if let error = MockURLProtocol.error {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            let response = MockURLProtocol.response ??
                HTTPURLResponse(
                    url: request.url!,
                    statusCode: 200,
                    httpVersion: nil,
                    headerFields: nil
                )!
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            if let data = MockURLProtocol.testData {
                client?.urlProtocol(self, didLoad: data)
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}

@MainActor
final class FlickrPhotoServiceTests: XCTestCase {
    private var service: PhotoServiceProtocol!

    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        service = FlickrPhotoService(session: session)
    }

    func testFetchPhotosSuccess() async throws {
        let json = """
        {
          "items": [
            {
              "title": "TestPhoto",
              "link": "https://example.com",
              "media": { "m": "https://example.com.jpg" },
              "description": "<p>Desc</p>",
              "author": "nobody@test.com (Author)",
              "published": "2025-01-01T12:00:00Z"
            }
          ]
        }
        """
        MockURLProtocol.testData = Data(json.utf8)

        let photos = try await service.fetchPhotos(tags: "test")

        XCTAssertEqual(photos.count, 1)
        XCTAssertEqual(photos[0].title, "TestPhoto")
        XCTAssertEqual(photos[0].media.m.absoluteString, "https://example.com.jpg")
    }

    func testFetchPhotosNetworkError() async {
        MockURLProtocol.error = URLError(.notConnectedToInternet)

        do {
            _ = try await service.fetchPhotos(tags: "error")
            XCTFail("Expected network error to be thrown")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
}
