//
//  LeaguesViewModel.swift
//  SportsApp
//
//  Created by Yomna Magdy  on 5/19/24.
//

import Foundation

class LeaguesViewModel{
    var bindResultToViewController: (() -> Void) = {}
        var result: [League]?

        func getLeaguesData(sportName: String) {
            NetworkServices().fetchLeaguesData(sportType: sportName) { [weak self] (leagues, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self?.result = leagues?.result
            
                self?.bindResultToViewController()
            }
        }
}
