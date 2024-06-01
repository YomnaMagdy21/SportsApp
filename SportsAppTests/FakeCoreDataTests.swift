//
//  FakeCoreDataTests.swift
//  SportsAppTests
//
//  Created by Omar  on 28/05/2024.
//
import XCTest
//import CoreData
@testable import SportsApp

final class DbServicesImplTests: XCTestCase {
    
    var coreDataManager: DbServicesImpl!
    var testLeagueKey: Int!
    
    override func setUpWithError() throws {
        coreDataManager = DbServicesImpl()
        testLeagueKey = 101
    }

    override func tearDownWithError() throws {
        coreDataManager = nil
        testLeagueKey = nil
    }
    
//    func createMockPersistentContainer() -> NSPersistentContainer {
//        let container = NSPersistentContainer(name: "SportsApp")
//        let description = NSPersistentStoreDescription()
//        description.type = NSInMemoryStoreType
//        container.persistentStoreDescriptions = [description]
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                fatalError("Failed to load store: \(error)")
//            }
//        }
//        return container
//    }

    func testAddLeague() {
        let leagueName = "Test League"
        let leagueLogo = "test_logo.png"
        let sportsType = "football"
        
        coreDataManager.addLeague(leagueName: leagueName, leagueLogo: leagueLogo, leagueKey: testLeagueKey, sportName: sportsType)
        
        XCTAssertTrue(coreDataManager.checkLeaguesData(leagueKey: testLeagueKey), "League should exist in Core Data after saving")
    }

    func testDeleteLeague() {
        let leagueName = "Test League"
        let leagueLogo = "test_logo.png"
        let sportsType = "football"

        coreDataManager.addLeague(leagueName: leagueName, leagueLogo: leagueLogo, leagueKey: testLeagueKey, sportName: sportsType)
        coreDataManager.deleteLeague(leagueKey: testLeagueKey)
        
        XCTAssertFalse(coreDataManager.checkLeaguesData(leagueKey: testLeagueKey), "League should not exist in Core Data after deletion")
    }

    func testFetchLeaguesData() {
            let leagueName1 = "Test League 1"
            let leagueLogo1 = "test_logo1.png"
            let leagueKey1 = 101
        let sportsType1 = "football"

            
            let leagueName2 = "Test League 2"
            let leagueLogo2 = "test_logo2.png"
            let leagueKey2 = 102
        let sportsType2 = "football"

            
            let initialCount = coreDataManager.fetchLeaguesData().count
            
        coreDataManager.addLeague(leagueName: leagueName1, leagueLogo: leagueLogo1, leagueKey: leagueKey1, sportName: sportsType1)
        coreDataManager.addLeague(leagueName: leagueName2, leagueLogo: leagueLogo2, leagueKey: leagueKey2, sportName: sportsType2)
            
            let retrievedLeagues = coreDataManager.fetchLeaguesData()
            
            XCTAssertEqual(retrievedLeagues.count, initialCount + 2)
            
            // Validate the added leagues are present
//            let addedLeague1 = retrievedLeagues.first { $0.league_key == leagueKey1 }
//            let addedLeague2 = retrievedLeagues.first { $0.league_key == leagueKey2 }
//            
//            XCTAssertNotNil(addedLeague1)
//            XCTAssertNotNil(addedLeague2)
//            
//            XCTAssertEqual(addedLeague1?.league_name, leagueName1)
//            XCTAssertEqual(addedLeague1?.league_logo, leagueLogo1)
//            
//            XCTAssertEqual(addedLeague2?.league_name, leagueName2)
//            XCTAssertEqual(addedLeague2?.league_logo, leagueLogo2)
        }
    func testCheckLeaguesData() {
        let leagueName = "Test League"
        let leagueLogo = "test_logo.png"
        let sportsType = "football"

        
        coreDataManager.addLeague(leagueName: leagueName, leagueLogo: leagueLogo, leagueKey: testLeagueKey, sportName: sportsType)
        
        let exists = coreDataManager.checkLeaguesData(leagueKey: testLeagueKey)
        
        XCTAssertTrue(exists, "League should exist in Core Data")
    }
}
