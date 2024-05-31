//
//  ViewController.swift
//  SportsApp
//
//  Created by Yomna Magdy  on 5/15/24.
//

import UIKit
import Reachability

class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let reachability = try! Reachability()
    
    @IBOutlet weak var collectionView: UICollectionView!
    var names : [String] = ["football","basketball","cricket","tennis"]
    var images : [String] = ["football1","basket","cricket2","tennis1"]
    var names2 : [String] = ["Football","Basketball","Cricket","Tennis"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        layout.itemSize = .zero
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0

        collectionView.collectionViewLayout = layout

        
        do {
                    try reachability.startNotifier()
                } catch {
                    print("Unable to start notifier")
                }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
        cell.img.image = UIImage(named: images[indexPath.row])
        cell.title.text = names2[indexPath.row]
      
        
        return cell
    
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2.4, height: view.frame.width/2.4)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if reachability.connection != .unavailable {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let leagueTVC = storyboard.instantiateViewController(withIdentifier: "leaguesTVC") as? LeaguesTableViewController{
                leagueTVC.sportType = names[indexPath.row]
                self.navigationController?.pushViewController(leagueTVC, animated: true)
            }
        }else{
            let alertController = UIAlertController(title: "Network Error!", message: "The device isn't connected to network, recheck the internet correctivily", preferredStyle: .alert)
                    
                  
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    
                 
                    alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
                    
       
        }
///
        }


}

