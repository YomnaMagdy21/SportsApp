//
//  LeaguesDetailsViewModel.swift
//  SportsApp
//
//  Created by Omar  on 18/05/2024.
//

import Foundation

class LeaguesDetailsViewModel{
    let networkService = NetworkServices()
    var bindTeamsLeague : (() -> ()) = {}
    var teams: [Result]?{
        didSet{
            bindTeamsLeague()
            print(teams?.first?.team_name ?? "empty")
        }
    }
    
    var bindUpcomingEvent : (() -> ()) = {}
    var upcomingResult : [UpcomingData]?
    
    func fetchTeams(leagueId: Int){
        networkService.fetchTeamsData(leagueId: leagueId) { response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                // Handle the error
            } else if let response = response {
                self.teams = response.result
                print(response.result?.count ?? -1)
                print(self.teams?.count ?? -1)
                print(self.teams?.first?.team_name ?? "empty")
               

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
            print(self?.upcomingResult?.first?.event_final_result ?? "no result")
        
            self?.bindUpcomingEvent()
            
        }
    }
    
    
    
}
