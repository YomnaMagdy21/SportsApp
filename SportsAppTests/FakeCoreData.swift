//
//  FakeCoreData.swift
//  SportsAppTests
//
//  Created by Omar  on 28/05/2024.
//
import Foundation
@testable import SportsApp

class DbServicesImplMock: DbServicesImpl {
    var addLeagueCalled = false
    var deleteLeagueCalled = false
    var checkLeaguesDataCalled = false
    var fetchLeaguesDataCalled = false
    
    var addedLeague: League?
    var deletedLeagueKey: Int?
    var leagueExistsResult: Bool = false
    var leagus: [League] = []

    override func addLeague(leagueName: String, leagueLogo: String, leagueKey: Int) {
        addLeagueCalled = true
        addedLeague = League(league_key: leagueKey, league_name: leagueName, league_logo: leagueLogo)
        leagus.append(addedLeague!)
    }
    
    override func deleteLeague(leagueKey: Int) {
        deleteLeagueCalled = true
        deletedLeagueKey = leagueKey
        leagus.removeAll { $0.league_key == leagueKey }
    }
    
    override func checkLeaguesData(leagueKey: Int) -> Bool {
        checkLeaguesDataCalled = true
        return leagus.contains { $0.league_key == leagueKey }
    }
    
    override func fetchLeaguesData() -> [League] {
        fetchLeaguesDataCalled = true
        return leagus
    }
}
