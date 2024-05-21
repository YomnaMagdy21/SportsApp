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
    
    
}
