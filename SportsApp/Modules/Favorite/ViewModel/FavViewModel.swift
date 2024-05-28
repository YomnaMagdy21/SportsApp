//
//  FavViewModel.swift
//  SportsApp
//
//  Created by Yomna Magdy  on 5/25/24.
//

import Foundation

import CoreData
class FavViewModel{
    var bindResultToFavTableViewController : (() -> ()) = {}
        var fav : [League]?

    func getFavData() ->[League]{
           
     //   self.fav = DbServicesImpl().fetchLeaguesData()
        self.bindResultToFavTableViewController()
            
        return DbServicesImpl().fetchLeaguesData()
    }
    
    func deleteFav(leagueId: Int){
        DbServicesImpl().deleteLeague(leagueKey: leagueId)
    }
}
