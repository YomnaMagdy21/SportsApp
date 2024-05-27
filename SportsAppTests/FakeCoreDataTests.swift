//
//  FakeCoreDataTests.swift
//  SportsAppTests
//
//  Created by Omar  on 28/05/2024.
//

import XCTest
@testable import SportsApp

class FakeCoreDataTests: XCTestCase {

    var fakeCoreData: FakeCoreData!
    var league1: League!
    var league2: League!
    var league3: League!
    
    override func setUp() {
        super.setUp()
        fakeCoreData = FakeCoreData()
        league1 = League(league_key: 101, league_name: "League 1", league_logo: "logo1.png")
        league2 = League(league_key: 102, league_name: "League 2", league_logo: "logo2.png")
        league3 = League(league_key: 103, league_name: "League 3", league_logo: "logo3.png")
    }

    override func tearDown() {
        fakeCoreData = nil
        league1 = nil
        league2 = nil
        league3 = nil
        super.tearDown()
    }

    func testSetLeagues() {
        fakeCoreData.setLeagues(leagues: [league1, league2])
        XCTAssertEqual(fakeCoreData.fetchLeaguesData().count, 2)
    }

    func testFetchLeaguesData() {
        fakeCoreData.setLeagues(leagues: [league1, league2])
        let leagues = fakeCoreData.fetchLeaguesData()
        XCTAssertEqual(leagues.count, 2)
        XCTAssertEqual(leagues[0].league_key, league1.league_key)
        XCTAssertEqual(leagues[1].league_key, league2.league_key)
    }

    func testCheckLeaguesData() {
        fakeCoreData.setLeagues(leagues: [league1, league2])
        XCTAssertTrue(fakeCoreData.checkLeaguesData(leagueKey: 101))
        XCTAssertFalse(fakeCoreData.checkLeaguesData(leagueKey: 999))
    }

    func testAddLeague() {
        fakeCoreData.addLeague(leagueName: league3.league_name ?? "", leagueLogo: league3.league_logo ?? "", leagueKey: league3.league_key ?? 0)
        XCTAssertTrue(fakeCoreData.checkLeaguesData(leagueKey: 103))
    }

    func testDeleteLeague() {
        fakeCoreData.setLeagues(leagues: [league1, league2, league3])
        fakeCoreData.deleteLeague(leagueKey: 102)
        XCTAssertFalse(fakeCoreData.checkLeaguesData(leagueKey: 102))
        XCTAssertEqual(fakeCoreData.fetchLeaguesData().count, 2)
    }
}
