//
//  FavTableViewController.swift
//  SportsApp
//
//  Created by Yomna Magdy  on 5/17/24.
//

import UIKit
import Kingfisher
import SafariServices
import CoreData


class FavTableViewController: UITableViewController ,SFSafariViewControllerDelegate{

    var  favViewModel : FavViewModel?
        var fav : [NSManagedObject]?
    //var league : [League]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
//           tableView.separatorInset = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 35)
       
        tableView.separatorStyle = .none

        //tableView.backgroundColor = .clear  // Set table view background color
                tableView.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        favViewModel = FavViewModel()
               favViewModel?.getFavData()
               fav = favViewModel?.fav
        tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fav?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fav", for: indexPath) as! FavTableViewCell
        
        let favItem = fav?[indexPath.row]
               if let leagueName = favItem?.value(forKey: "league_name") as? String {
                      cell.name.text = leagueName
                  } else {
                      cell.name.text = "No name"
                  }
               if let leagueImg = favItem?.value(forKey: "league_logo") as? String {
                   let imageUrl = URL(string: leagueImg)
           
                   cell.badge.kf.setImage(with: imageUrl, placeholder: UIImage(named: "barcelona"))
                   
                  }

        return cell
    }
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
   
   

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
              let favDeletedItem = fav?[indexPath.row]
              if let leagueKey = favDeletedItem?.value(forKey: "league_key") as? Int {
                  favViewModel?.deleteFav(leagueId: leagueKey)
                  
                fav?.remove(at: indexPath.row)
                  
                 
                  tableView.deleteRows(at: [indexPath], with: .fade)
                
                 } else {
                     print("can't delete")
                 }
              
          }
       }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "SecStoryboard", bundle: nil)
        if let leagueDetailsCollectionViewController = storyboard.instantiateViewController(withIdentifier: "LeagueDetailsScreen") as? LeaguesDetailsCollectionViewController {
            
            let navigationController = UINavigationController(rootViewController: leagueDetailsCollectionViewController)
            
            let favItem = fav?[indexPath.row]
            if let leagueKey = favItem?.value(forKey: "league_key") as? Int {
                leagueDetailsCollectionViewController.leagueId = leagueKey
               } else {
                   print("no key")
               }
                   if let leagueName = favItem?.value(forKey: "league_name") as? String {
                       leagueDetailsCollectionViewController.leagueName = leagueName

                      } else {
                          print("no name")
                      }
                   if let leagueImg = favItem?.value(forKey: "league_logo") as? String {
                     
                       leagueDetailsCollectionViewController.leagueLogo = leagueImg
                       
                   }else {
                       leagueDetailsCollectionViewController.leagueLogo = "barcelona"
                   }
           
            
            
            
            // Set the presentation style to full screen
            navigationController.modalPresentationStyle = .fullScreen
            
            // Present the navigation controller
            present(navigationController, animated: true, completion: nil)
        }
    }

  
    @IBAction func showVideo(_ sender: Any) {
        guard let url = URL(string: "https://www.youtube.com/watch?v=Jlj0wc3USrU") else { return  }
        
        let videoVC = SFSafariViewController(url: url)
        videoVC.delegate = self
        present(videoVC, animated: true, completion: nil)
  
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
