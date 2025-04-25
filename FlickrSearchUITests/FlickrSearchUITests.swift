//  FlickrSearchUITests.swift
//  FlickrSearchUITests
//  Created by Irina Arkhireeva on 25.04.2025.

import XCTest

final class FlickrSearchUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testSearchAndDetailFlow() throws {
        let searchField = app.textFields["Search tags..."]
        XCTAssertTrue(searchField.exists, "Search field must be present")

        searchField.tap()
        searchField.typeText("porcupine")

        let firstThumbnail = app.images.matching(NSPredicate(
            format: "identifier BEGINSWITH %@", "photoThumbnail_"
        )).firstMatch
        XCTAssertTrue(
            firstThumbnail.waitForExistence(timeout: 5),
            "Expected at least one thumbnail"
        )

        firstThumbnail.tap()

        XCTAssertTrue(
            app.staticTexts["detailTitle"].waitForExistence(timeout: 2),
            "Detail title should appear"
        )
        XCTAssertTrue(app.staticTexts["detailDescription"].exists)
        XCTAssertTrue(app.staticTexts["detailAuthor"].exists)
        XCTAssertTrue(app.staticTexts["detailPublishDate"].exists)
    }
}
