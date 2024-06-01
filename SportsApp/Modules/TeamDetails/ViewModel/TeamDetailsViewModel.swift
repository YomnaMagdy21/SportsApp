//
//  TeamDetailsViewModel.swift
//  SportsApp
//
//  Created by Omar  on 22/05/2024.
//

import Foundation

class TeamDetailsViewModel{
    let networkService = NetworkServices()
    var bindTeamDetails : (() -> ()) = {}
    var teams: [Result]?{
        didSet{
            bindTeamDetails()
            print(teams?.first?.team_name ?? "empty")
        }
    }
    func fetchTeamDetails(teamId: Int , sportsType: String){
        networkService.fetchTeamsDetails(teamId: teamId , sportsType: sportsType) { response, error in
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
