//
//  LeaguesTableViewController.swift
//  SportsApp
//
//  Created by Yomna Magdy  on 5/17/24.
//

import UIKit
import SafariServices

class LeaguesTableViewController: UITableViewController ,SFSafariViewControllerDelegate{
    
    var league : [League]?
    var leagueViewModel : LeaguesViewModel?
    var sportType : String?
    var indicator : UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        leagueViewModel = LeaguesViewModel()
        leagueViewModel?.bindResultToViewController = { [weak self] in
                   DispatchQueue.main.async {
                       self?.league = self?.leagueViewModel?.result
                       self?.indicator?.stopAnimating()
                       
                       self?.tableView.reloadData()
                   }
               }
        indicator = UIActivityIndicatorView(style: .medium)
                  indicator!.center = view.center
                  indicator!.startAnimating()
                 view.addSubview(indicator!)
        leagueViewModel?.getLeaguesData(sportName: sportType ?? "football")
    }

    // MARK: - Table view data source

    @IBAction func showVideo(_ sender: Any) {
        guard let url = URL(string: "https://www.youtube.com/watch?v=Jlj0wc3USrU") else { return  }
        
        let videoVC = SFSafariViewController(url: url)
        videoVC.delegate = self
        present(videoVC, animated: true, completion: nil)
    }
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        print("finish")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return league?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "league", for: indexPath) as! TableViewCell
//        
//        let imageUrl = URL(string: "https://i.ebayimg.com/images/g/nMIAAOSwi15kY5HN/s-l1600.jpg")
//        cell.imgLeague.kf.setImage(with: imageUrl)
//        cell.TitleLeague.text = "title"
        cell.TitleLeague.text = self.league?[indexPath.row].league_name
        let imgUrl = URL(string: self.league?[indexPath.row].league_logo ?? "")
        cell.imgLeague.kf.setImage(with: imgUrl, placeholder: UIImage(named: "barcelona"))
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 100 // Adjust based on your design
     }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "SecStoryboard", bundle: nil)
        if let leagueDetailsCollectionViewController = storyboard.instantiateViewController(withIdentifier: "LeagueDetailsScreen") as? LeaguesDetailsCollectionViewController {
            
            // Create a navigation controller with your view controller
            let navigationController = UINavigationController(rootViewController: leagueDetailsCollectionViewController)
            leagueDetailsCollectionViewController.leagueId = self.league?[indexPath.row].league_key
            leagueDetailsCollectionViewController.leagueName = self.league?[indexPath.row].league_name
            leagueDetailsCollectionViewController.leagueLogo = self.league?[indexPath.row].league_logo
            leagueDetailsCollectionViewController.sportsType = sportType
            
            // Set the presentation style to full screen
            navigationController.modalPresentationStyle = .fullScreen
            
            // Present the navigation controller
            present(navigationController, animated: true, completion: nil)
        }
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
