//  SearchViewModelTests.swift
//  FlickrSearchTests
//  Created by Irina Arkhireeva on 25.04.2025.

import XCTest
@testable import FlickrSearch

final class MockPhotoService: PhotoServiceProtocol {
    func fetchPhotos(tags: String) async throws -> [Photo] {
        [Photo(
            title: "MockTitle",
            link: URL(string: "https://mock.com")!,
            media: Photo.Media(m: URL(string: "https://mock.com.jpg")!),
            description: "<p>Mock</p>",
            author: "mock@mock.com (Mock Author)",
            published: Date()
        )]
    }
}

struct SlowMockPhotoService: PhotoServiceProtocol {
    func fetchPhotos(tags: String) async throws -> [Photo] {
        try await Task.sleep(nanoseconds: 300_000_000)
        return []
    }
}

@MainActor
final class SearchViewModelTests: XCTestCase {
    func testSearchUpdatesPhotos() async throws {
        let vm = SearchViewModel(service: MockPhotoService())
        vm.query = "test"
        try await Task.sleep(nanoseconds: 500_000_000)
        XCTAssertEqual(vm.photos.count, 1)
        XCTAssertEqual(vm.photos.first?.title, "MockTitle")
    }

    func testEmptyQueryClearsPhotos() async throws {
        let vm = SearchViewModel(service: MockPhotoService())
        vm.query = "initial"
        try await Task.sleep(nanoseconds: 500_000_000)
        XCTAssertFalse(vm.photos.isEmpty)

        vm.query = ""
        try await Task.sleep(nanoseconds: 400_000_000)
        XCTAssertTrue(vm.photos.isEmpty)
    }

    func testLoadingIndicatorBehavior() async throws {
        let vm = SearchViewModel(service: SlowMockPhotoService())
        XCTAssertFalse(vm.isLoading)

        vm.query = "load"
        XCTAssertTrue(vm.isLoading)

        try await Task.sleep(nanoseconds: 350_000_000)
        XCTAssertFalse(vm.isLoading)
    }
}
