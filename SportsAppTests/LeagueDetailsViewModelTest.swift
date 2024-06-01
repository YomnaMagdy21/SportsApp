//
//  LeagueDetailsViewModelTest.swift
//  SportsAppTests
//
//  Created by Omar  on 29/05/2024.
//

import XCTest
@testable import SportsApp

final class LeaguesDetailsViewModelTests: XCTestCase {
    
    var viewModel: LeaguesDetailsViewModel!
    var networkServicesMock: MockNetworkService!
    var dbServicesMock: DbServicesImplMock!
    
    override func setUpWithError() throws {
        networkServicesMock = MockNetworkService()
        dbServicesMock = DbServicesImplMock()
        
        viewModel = LeaguesDetailsViewModel()
        viewModel.networkService = networkServicesMock
        viewModel.dbService = dbServicesMock
    }
    
    override func tearDownWithError() throws {
        networkServicesMock = nil
        dbServicesMock = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchTeams() {
        let expectation = self.expectation(description: "Fetch Teams")
        viewModel.bindTeamsLeague = {
            expectation.fulfill()
        }
        
        viewModel.fetchTeams(leagueId: 1 , sportsType: "football")
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(networkServicesMock.leagueTeamsResponse, "leagueTeamsResponse should not be nil")
        XCTAssertEqual(viewModel.teams?.count, 1)
        XCTAssertEqual(viewModel.teams?.first?.team_name, "Spezia")
    }
    
    func testGetUpcomingResult() {
        let expectation = self.expectation(description: "Fetch Upcoming Results")
        viewModel.bindUpcomingEvent = {
            expectation.fulfill()
        }
        
        viewModel.getUpcomingResult(sportName: "Football", leagueId: 1)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(networkServicesMock.upcoming, "upcoming should not be nil")
        XCTAssertEqual(viewModel.upcomingResult?.count, 1)
        XCTAssertEqual(viewModel.upcomingResult?.first?.event_home_team, "Venezia")
    }
    
    func testGetLatestResult() {
        let expectation = self.expectation(description: "Fetch Latest Results")
        viewModel.bindLatestEvent = {
            expectation.fulfill()
        }
        
        viewModel.getLatestResult(sportName: "Football", leagueId: 1)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(networkServicesMock.upcoming, "latest should not be nil")
        XCTAssertEqual(viewModel.latestResult?.count, 1)
        XCTAssertEqual(viewModel.latestResult?.first?.event_home_team, "Venezia")
    }
    
    func testAddLeague() {
        // Get the count of leagues before adding a new league
        let initialLeagues = dbServicesMock.fetchLeaguesData()
        let initialCount = initialLeagues.count
        
        // Add a new league
        viewModel.addLeague(leagueName: "Test League", leagueLogo: "test_logo.png", leagueKey: 1)
        
        // Fetch the leagues after adding the new league
        let updatedLeagues = dbServicesMock.fetchLeaguesData()
        let updatedCount = updatedLeagues.count
        
        // Verify that the count has increased by 1
        XCTAssertEqual(updatedCount, initialCount + 1, "The count of leagues should increase by 1 after adding a new league")
        
        // Verify that the newly added league exists
        XCTAssertTrue(viewModel.leagueExists(leagueKey: 1), "The newly added league should exist in the database")
    }


    
    func testDeleteLeague() {
        // Add a new league
        viewModel.addLeague(leagueName: "Test League", leagueLogo: "test_logo.png", leagueKey: 1)
        
        // Ensure the league has been added
        XCTAssertTrue(viewModel.leagueExists(leagueKey: 1), "The league should exist in the database after adding it")
        
        // Delete the league
        viewModel.deleteLeague(leagueKey: 1)
        
        // Verify that the league no longer exists
        XCTAssertFalse(viewModel.leagueExists(leagueKey: 1), "The league should not exist in the database after deletion")
    }

    func testLeagueExists() {
        viewModel.addLeague(leagueName: "Test League", leagueLogo: "test_logo.png", leagueKey: 1)
        let exists = viewModel.leagueExists(leagueKey: 1)
        
        XCTAssertTrue(exists)
    }
}
