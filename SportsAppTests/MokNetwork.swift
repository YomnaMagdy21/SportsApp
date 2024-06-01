//
//  MokNetwork.swift
//  
//
//  Created by Omar  on 27/05/2024.
//

import XCTest
@testable import SportsApp

final class MokNetwork: XCTestCase {

    var mockObj : MockNetworkService?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockObj = MockNetworkService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockObj = nil
    }
    func testMockFetchTeamsData(){
        mockObj?.fetchTeamsData(leagueId: 206, sportsType: "football") { result , error in
            if let error = error {
                XCTFail()
            }else{
                
                XCTAssertNotNil(result)
            }
                }
    }
    func testMockFetchLeaguesData(){
         
        mockObj?.fetchLeaguesData(sportType: "football") { result , error in
            if let error = error {
                XCTFail()
            }else{
               
                XCTAssertNotNil(result)
            }
                }
        }
    func testMockFetchUpcomingData(){
         
        mockObj?.fetchUpcomingData(sportType: "football", leagueId: 206) { result , error in
            if let error = error {
                XCTFail()
            }else{
                
                XCTAssertNotNil(result)
            }
                }
        }
    func testMockFetchLatestData(){
         
        mockObj?.fetchLatestEvent(sportType: "football", leagueId: 206) { result , error in
            if let error = error {
                XCTFail()
            }else{
                
                XCTAssertNotNil(result)
            }
                }
        }

    func testMockFetchTeamsDetailsData(){
        mockObj?.fetchTeamsDetails(teamId: 4977, sportsType: "football"){ result , error in
            if let error = error {
                XCTFail()
            }else{
                
                XCTAssertNotNil(result)
            }
                }
    }

}
