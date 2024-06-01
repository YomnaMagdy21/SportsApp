//
//  LeaguesDetailsViewModel.swift
//  SportsApp
//
//  Created by Omar  on 18/05/2024.
//

import Foundation

class LeaguesDetailsViewModel{
    var networkService : NetworkServicesProtocol = NetworkServices()
    var dbService = DbServicesImpl()
    var bindTeamsLeague : (() -> ()) = {}
    var teams: [Result]?{
        didSet{
            bindTeamsLeague()
//            print(teams?.first?.team_name ?? "empty")
        }
    }
    
    var bindUpcomingEvent : (() -> ()) = {}
    var upcomingResult : [EventsData]?
    
    var bindLatestEvent : (() -> ()) = {}
    var latestResult : [EventsData]?
    
    func fetchTeams(leagueId: Int , sportsType:String){
        networkService.fetchTeamsData(leagueId: leagueId, sportsType: sportsType) { response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                // Handle the error
            } else if let response = response {
                self.teams = response.result
//                print(response.result?.count ?? -1)
//                print(self.teams?.count ?? -1)
//                print(self.teams?.first?.team_name ?? "empty")
               

//                DispatchQueue.main.async {
//                    self.collectionView.reloadData() // Reload collection view after data is assigned
//                }
            }
        }

    }
    
    func getUpcomingResult(sportName: String,leagueId: Int){
        networkService.fetchUpcomingData(sportType: sportName,leagueId: leagueId){[weak self] (upcoming, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self?.upcomingResult = upcoming?.result
//            print(self?.upcomingResult?.first?.event_final_result ?? "no result")
        
            self?.bindUpcomingEvent()
            
        }
    }
    
    func getLatestResult(sportName: String,leagueId: Int){
        networkService.fetchLatestEvent(sportType: sportName, leagueId: leagueId){[weak self] (latest, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self?.latestResult = latest?.result
//            print(self?.latestResult?.first?.event_final_result ?? "no result")
        
            self?.bindLatestEvent()
            
        }
    }
    
    // db functions
    func addLeague(leagueName: String, leagueLogo: String, leagueKey: Int,sportName: String) {
          dbService.addLeague(leagueName: leagueName, leagueLogo: leagueLogo, leagueKey: leagueKey,sportName: sportName)
      }
      
    func deleteLeague(leagueKey: Int) {
           dbService.deleteLeague(leagueKey: leagueKey)
       }
    func leagueExists(leagueKey: Int) -> Bool {
          return dbService.checkLeaguesData(leagueKey: leagueKey)
      }}
