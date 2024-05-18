//
//  TeamDetailCollectionViewController.swift
//  SportsApp
//
//  Created by Omar  on 18/05/2024.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "CustomCell"
private let teamsCellReuseIdentifier = "TeamsCell"
private let bottomSectionReuseIdentifier = "BottomSectionCell"

class TeamDetailCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register custom cells
        let upcomingEventsNib = UINib(nibName: "TeamDetailsTopSectionCollectionViewCell", bundle: nil)
        self.collectionView!.register(upcomingEventsNib, forCellWithReuseIdentifier: reuseIdentifier)
        
        let teamsCellNib = UINib(nibName: "LeaguesTeamsCellCollectionViewCell", bundle: nil)
        self.collectionView!.register(teamsCellNib, forCellWithReuseIdentifier: teamsCellReuseIdentifier)
        
        let bottomSectionNib = UINib(nibName: "TeamDetailsBottomSectionCollectionViewCell", bundle: nil)
        self.collectionView!.register(bottomSectionNib, forCellWithReuseIdentifier: bottomSectionReuseIdentifier)
        
        // Set up the collection view layout
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
    }
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return self.drawTheTopSection()
            case 1:
                return self.drawTheMiddleSection()
            case 2:
                return self.drawTheBottomSection()
            default:
                return nil
            }
        }
    }
    
    func drawTheTopSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    func drawTheMiddleSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    func drawTheBottomSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0, 2:
            return 1
        case 1:
            return 10 // Change this to the number of items you want for the middle section
        default:
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TeamDetailsTopSectionCollectionViewCell
            // Configure the custom cell
            // cell.customLabel.text = "Item \(indexPath.row + 1)"
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamsCellReuseIdentifier, for: indexPath) as! LeaguesTeamsCellCollectionViewCell
            // Configure the custom cell
            let imageUrl = URL(string: "https://www.fifarosters.com/assets/players/fifa24/faces/209331.png")!
            cell.configure(with: imageUrl)
            cell.teamName.text = "Mohamed Salah"
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bottomSectionReuseIdentifier, for: indexPath) as! TeamDetailsBottomSectionCollectionViewCell
            // Configure the custom cell for the bottom section
            // cell.customLabel.text = "Bottom Item \(indexPath.row + 1)"
            return cell
        default:
            fatalError("Unexpected section")
        }
    }




    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}