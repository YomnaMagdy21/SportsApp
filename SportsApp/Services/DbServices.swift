//
//  DbServices.swift
//  SportsApp
//
//  Created by Omar  on 22/05/2024.
//

import Foundation
import CoreData
import UIKit

protocol DbServices {
    func fetchLeaguesData()
    func checkLeaguesData() -> Bool 

}
class DbServicesImpl : DbServices{
    
    let appDelegate : AppDelegate
    let context : NSManagedObjectContext
    var leagues : [NSManagedObject] = []
    let league : League
    
    init(){
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = self.appDelegate.persistentContainer.viewContext
        league = League()
    }
    
    func fetchLeaguesData() {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(
            entityName: "FavLeagues")
        
        do{
            self.leagues = try context.fetch(fetchRequest)
            var league = League()
            for fav in leagues{
               
                fav.value(forKey: "league_name")
                fav.value(forKey: "league_logo")
                fav.value(forKey: "league_key")
                leagues.append(fav)
            }
            
        }catch{
            print("Failed to fetch data: \(error.localizedDescription)")
        }
    }
    func checkLeaguesData() -> Bool {
       
        let fetchRequest = NSFetchRequest<NSManagedObject>(
            entityName: "FavLeagues")
        let predicate = NSPredicate(format: "league_name == %@", league.league_name ?? "no name")
        fetchRequest.predicate = predicate
        
        do {
            let fav = try context.fetch(fetchRequest)
            return !fav.isEmpty
        } catch {
            print("failed to get data: \(error.localizedDescription)")
            return false
        }
    }

   
    
}
