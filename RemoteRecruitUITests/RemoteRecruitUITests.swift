//
//  RemoteRecruitUITests.swift
//  RemoteRecruitUITests
//
//  Created by rmehla on 05/06/26.
//

import XCTest

class RemoteRecruitUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSearchFiltersJobs() {
        let app = XCUIApplication()
        app.launch()
        print("SearchFilterJobs: ",app.debugDescription)
        
        let searchBar = app.searchFields["jobsSearchBar"]

        XCTAssertTrue(searchBar.waitForExistence(timeout: 10))
        print("Exists:", searchBar.exists)
        print("Hittable:", searchBar.isHittable)
        searchBar.tap()
        searchBar.typeText("New")

        let table = app.tables["jobsTableView"]

        XCTAssertGreaterThan(table.cells.count, 0)
    }

    func testSearchShowsEmptyStateWhenNoResultsFound() {
        let app = XCUIApplication()
        app.launch()
        print("SearchShowsEmptyState: ",app.debugDescription)
        
        let searchBar = app.searchFields["jobsSearchBar"]

        searchBar.tap()
        searchBar.typeText("XYZ123NONEXISTINGJOB")
        print("SearchShowsEmptyState Exists:", searchBar.exists)
        print("Hittable:", searchBar.isHittable)

        let emptyView = app.otherElements["emptyStateView"]

        XCTAssertTrue(emptyView.waitForExistence(timeout: 5))
    }
    
    func testCancelSearchRestoresData() {

        let app = XCUIApplication()
        app.launch()
        print("CancelSearchRestoresData: ",app.debugDescription)
        let searchBar = app.searchFields["jobsSearchBar"]

        searchBar.tap()
        searchBar.typeText("XYZ123NONEXISTINGJOB")
        print("CancelSearchRestoresData Exists:", searchBar.exists)
        print("Hittable:", searchBar.isHittable)

        app.buttons["Cancel"].tap()

        let table = app.tables["jobsTableView"]

        XCTAssertGreaterThan(table.cells.count, 0)
    }
    
    func testSelectingJobNavigatesToDetailScreen() {

        let app = XCUIApplication()
        app.launch()

        let table = app.tables["jobsTableView"]

        XCTAssertTrue(table.waitForExistence(timeout: 20))

        let firstCell = table.cells.element(boundBy: 0)

        XCTAssertTrue(firstCell.exists)

        firstCell.tap()

        let detailScreen = app.otherElements["RemoteJobDetailView"]

        XCTAssertTrue(detailScreen.waitForExistence(timeout: 10))
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
