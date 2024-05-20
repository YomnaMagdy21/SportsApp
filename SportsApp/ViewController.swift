//
//  ViewController.swift
//  SportsApp
//
//  Created by Yomna Magdy  on 5/15/24.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var names : [String] = ["football","basketball","cricket","tennis"]
    var images : [String] = ["football","basketball","cricket","tennis"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                   layout.estimatedItemSize = .zero
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
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
        cell.title.text = names[indexPath.row]
      
        
        return cell
    
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2.4, height: view.frame.width/2)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            print("Item selected at indexPath: \(indexPath)")
        
            performSegue(withIdentifier: "goToLeague", sender: indexPath)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                if let leagueTVC = storyboard.instantiateViewController(withIdentifier: "leaguesTVC") as? LeaguesTableViewController {
//                    leagueTVC.sportType = names[indexPath.row]
////                    leagueTVC.modalPresentationStyle = .fullScreen
//
//                    self.present(leagueTVC, animated: true, completion: nil)
//                }
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "goToLeague" {
                if let indexPath = sender as? IndexPath {
                    if let leaguesTVC = segue.destination as? LeaguesTableViewController {
                        leaguesTVC.sportType = names[indexPath.row]
                    }
                }
            }
        
    }

}

