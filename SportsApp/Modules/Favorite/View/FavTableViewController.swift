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
import Reachability

class FavTableViewController: UITableViewController ,SFSafariViewControllerDelegate{

    let reachability = try! Reachability()
    var  favViewModel : FavViewModel?
      //  var fav : [NSManagedObject]?
    var league : [League]?
    override func viewDidLoad() {
        super.viewDidLoad()

      
       
        tableView.separatorStyle = .none
          tableView.tableFooterView = UIView()
        

        do {
                    try reachability.startNotifier()
                } catch {
                    print("Unable to start notifier")
                }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarItem.title = "Favorite"
        favViewModel = FavViewModel()
        league = favViewModel?.getFavData()
        print("sport type:\(league?.first?.sportType)")
        tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return league?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fav", for: indexPath) as! FavTableViewCell
        
        if let favItem = league?[indexPath.row] {
            cell.name.text = favItem.league_name ?? "No name"
            
            if let leagueImg = favItem.league_logo {
                if let imageUrl = URL(string: leagueImg) {
                    cell.badge.kf.setImage(with: imageUrl, placeholder: UIImage(named: "barcelona"))
                } else {
                    cell.badge.image = UIImage(named: "barcelona")
                }
            } else {
                cell.badge.image = UIImage(named: "barcelona")
            }
        } else {
            cell.name.text = "No name"
            cell.badge.image = UIImage(named: "barcelona")
        }

        return cell
    }
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
   
   

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favDeletedItem = league?[indexPath.row]
            if let leagueKey = favDeletedItem?.league_key {
                favViewModel?.deleteFav(leagueId: leagueKey)
                league?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                print("Can't delete: no league key")
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if reachability.connection != .unavailable {
        let storyboard = UIStoryboard(name: "SecStoryboard", bundle: nil)
            if let leagueDetailsCollectionViewController = storyboard.instantiateViewController(withIdentifier: "LeagueDetailsScreen") as? LeaguesDetailsCollectionViewController {
                
                let navigationController = UINavigationController(rootViewController: leagueDetailsCollectionViewController)
                
                if let favItem = league?[indexPath.row] {
                    leagueDetailsCollectionViewController.leagueId = favItem.league_key
                    leagueDetailsCollectionViewController.leagueName = favItem.league_name
                    leagueDetailsCollectionViewController.leagueLogo = favItem.league_logo ?? "barcelona"
                    leagueDetailsCollectionViewController.sportsType =
                    favItem.sportType
                    
                    
                    navigationController.modalPresentationStyle = .fullScreen
                    
                    
                    present(navigationController, animated: true, completion: nil)
                } else {
                    print("No league item found at index \(indexPath.row)")
                }
            }
        }
        else{
            let alertController = UIAlertController(title: "Network Error!", message: "The device isn't connected to network, recheck the internet correctivily", preferredStyle: .alert)
                    
                  
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    
                 
                    alertController.addAction(okAction)
                    
                    
                    present(alertController, animated: true, completion: nil)
        }
    }

    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        
        let headerLabel = UILabel()
        headerLabel.text = "Favorite"
        headerLabel.textColor = UIColor(hex: "#006400", alpha: 0.8)
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.boldSystemFont(ofSize: 16)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        headerView.addSubview(headerLabel)
        
       
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 8),
            headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -8)
        ])
        
        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
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
