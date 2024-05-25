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
        var fav : [NSManagedObject]?

    func getFavData() {
           
               
              //  self?.fav =  DbServices().fetchLeaguesData()
            
                self.bindResultToFavTableViewController()
            
        }
}
