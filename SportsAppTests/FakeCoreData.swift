//
//  FakeCoreData.swift
//  SportsAppTests
//
//  Created by Omar  on 28/05/2024.
//
import Foundation
@testable import SportsApp

class FakeCoreData { // don't forgeet to confirm dbprotocol
    private var leagues: [League] = []
    
    func setLeagues(leagues: [League]) {
        self.leagues = leagues
    }
    
    func fetchLeaguesData() -> [League] {
        return leagues
    }
    
    func checkLeaguesData(leagueKey: Int) -> Bool {
        return leagues.contains { $0.league_key == leagueKey }
    }
    
    func addLeague(leagueName: String, leagueLogo: String, leagueKey: Int) {
        let newLeague = League(league_key: leagueKey, league_name: leagueName, league_logo: leagueLogo)
        leagues.append(newLeague)
    }
    
    func deleteLeague(leagueKey: Int) {
        leagues.removeAll { $0.league_key == leagueKey }
    }
}
