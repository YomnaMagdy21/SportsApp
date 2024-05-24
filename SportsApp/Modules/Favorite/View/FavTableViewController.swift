//
//  FavTableViewController.swift
//  SportsApp
//
//  Created by Yomna Magdy  on 5/17/24.
//

import UIKit
import Kingfisher
import SafariServices


class FavTableViewController: UITableViewController ,SFSafariViewControllerDelegate{

 
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fav", for: indexPath) as! FavTableViewCell
        
        let imageUrl = URL(string: "https://i.ebayimg.com/images/g/nMIAAOSwi15kY5HN/s-l1600.jpg")
//             
        cell.badge.kf.setImage(with: imageUrl, placeholder: UIImage(named: "barcelona"))
        cell.name.text = "title"
//
//       

        return cell
    }
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Adjust based on your design
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
