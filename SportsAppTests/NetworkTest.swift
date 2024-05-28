//
//  NetworkTest.swift
//  SportsAppTests
//
//  Created by Yomna Magdy  on 5/28/24.
//

import XCTest
@testable import SportsApp

final class NetworkTest: XCTestCase {
    var networkService : NetworkServices?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        networkService = NetworkServices()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkService = nil
    }
    func testGetTeamesData(){
        let expectaion = expectation(description: "wait for api")
        NetworkServices().fetchTeamsData(leagueId: 206){result,error in
            if let error = error {
                XCTFail()
                print(error)
            }else{
                XCTAssertEqual(result?.success,1)
                
                expectaion.fulfill()
            }
            
        }
        waitForExpectations(timeout: 5)
    }

    func testGetTeamesDetailsData(){
        let expectaion = expectation(description: "wait for api")
        NetworkServices().fetchTeamsDetails(teamId: 4977){result,error in
            if let error = error {
                XCTFail()
                print(error)
            }else{
                XCTAssertEqual(result?.success,1)
                
                expectaion.fulfill()
            }
            
        }
        waitForExpectations(timeout: 5)
    }
    func testGetLeagueData(){
           let expectaion = expectation(description: "wait for api")
        NetworkServices().fetchLeaguesData(sportType:"football"){result,error in
               if let error = error {
                   XCTFail()
                   print(error)
               }else{
                   XCTAssertEqual(result?.success,1)
                   
                   expectaion.fulfill()
               }
               
           }
           waitForExpectations(timeout: 5)
         
       }
       func testGetUpcomingData(){
           let expectaion = expectation(description: "wait for api")
           NetworkServices().fetchUpcomingData(sportType:"football", leagueId: 206){result,error in
               if let error = error {
                   XCTFail()
                   print(error)
               }else{
                   XCTAssertEqual(result?.success,1)
                   
                   expectaion.fulfill()
               }
               
           }
           waitForExpectations(timeout: 2)
         
       }

    func testGetLatestEvent(){
        let expectaion = expectation(description: "wait for api")
        NetworkServices().fetchLatestEvent(sportType:"football", leagueId: 206){result,error in
            if let error = error {
                XCTFail()
                print(error)
            }else{
                XCTAssertEqual(result?.success,1)
                
                expectaion.fulfill()
            }
            
        }
        waitForExpectations(timeout: 5)
      
    }

}
