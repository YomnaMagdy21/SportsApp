//
//  TeamDetailsViewModelTest.swift
//  SportsAppTests
//
//  Created by Omar  on 01/06/2024.
//

import XCTest
@testable import SportsApp

final class TeamDetailsViewModelTest: XCTestCase {
    var viewModel : TeamDetailsViewModel!

    override func setUpWithError() throws {
            viewModel = TeamDetailsViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func testGetTeams(){
        let expectation = self.expectation(description: "Fetch Teams")
        viewModel.bindTeamDetails = {
            expectation.fulfill()
        }
        
        viewModel.fetchTeamDetails(teamId: 152, sportsType: "football")
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(self.viewModel.teams)
        XCTAssertEqual(viewModel.teams?.count, 1)
        XCTAssertEqual(viewModel.teams?.first?.team_name, "Napoli")
        
    }

}
