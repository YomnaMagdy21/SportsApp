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
    func fetchLeaguesData() -> [League]
    func checkLeaguesData(leagueKey: Int) -> Bool
    func addLeague(leagueName: String, leagueLogo: String, leagueKey: Int)
    func deleteLeague(leagueKey: Int)

}
class DbServicesImpl : DbServices{
    
    let appDelegate : AppDelegate
    let context : NSManagedObjectContext
    var leagues : [NSManagedObject] = []
    var leaguesArray : [League] = []
    let league : League
   
    
    init(){
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = self.appDelegate.persistentContainer.viewContext
        league = League()
    }
    func fetchLeaguesData() -> [League] {
          leaguesArray = []
          let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavLeagues")

          do {
              self.leagues = try context.fetch(fetchRequest)
              for fav in leagues {
                  if let leagueName = fav.value(forKey: "league_name") as? String,
                     let leagueLogo = fav.value(forKey: "league_logo") as? String,
                     let leagueKey = fav.value(forKey: "league_key") as? Int {
                      
                      let league = League(league_key: leagueKey, league_name: leagueName, league_logo: leagueLogo)
                      leaguesArray.append(league)
                  }
              }

          } catch {
              print("Failed to fetch data: \(error.localizedDescription)")
          }
          return leaguesArray
      }

    func checkLeaguesData(leagueKey: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavLeagues")
        let predicate = NSPredicate(format: "league_key == %@", String(leagueKey))
        fetchRequest.predicate = predicate
        
        do {
            let fav = try context.fetch(fetchRequest)
            return !fav.isEmpty
        } catch {
            print("Failed to get data: \(error.localizedDescription)")
            return false
        }
    }


    func addLeague(leagueName: String, leagueLogo: String, leagueKey: Int) {
        let entity = NSEntityDescription.entity(forEntityName: "FavLeagues", in: context)!
        let newLeague = NSManagedObject(entity: entity, insertInto: context)
        
        newLeague.setValue(leagueName, forKey: "league_name")
        newLeague.setValue(leagueLogo, forKey: "league_logo")
        newLeague.setValue(leagueKey, forKey: "league_key")
        
        do {
            try context.save()
            leagues.append(newLeague)
        } catch {
            print("Failed to save league: \(error.localizedDescription)")
        }
    }
    
    func deleteLeague(leagueKey: Int) {
          let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavLeagues")
          let predicate = NSPredicate(format: "league_key == %d", leagueKey)
          fetchRequest.predicate = predicate

          do {
              let leaguesToDelete = try context.fetch(fetchRequest)
              for league in leaguesToDelete {
                  context.delete(league)
              }
              try context.save()
          } catch {
              print("Failed to delete league: \(error.localizedDescription)")
          }
      }
    
}
