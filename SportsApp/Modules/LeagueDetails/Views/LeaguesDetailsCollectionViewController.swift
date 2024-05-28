//
//  LeaguesDetailsCollectionViewController.swift
//  SportsApp
//
//  Created by Omar  on 17/05/2024.
//
import UIKit
import Kingfisher

private let reuseIdentifier = "CustomCell"
private let teamsCellReuseIdentifier = "TeamsCell"

class LeaguesDetailsCollectionViewController: UICollectionViewController {
    var leagueDetailsViewModel:LeaguesDetailsViewModel?
    
    var upcoming : [EventsData]?
    var latest : [EventsData]?
    var leagueId:Int?
    var leagueName:String?
    var leagueLogo:String?
    var isHeartFilled = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "League Details"
        leagueDetailsViewModel = LeaguesDetailsViewModel()
        navigationItem.leftBarButtonItem = createCustomBackButton()
        print(leagueId ?? 0)
//               navigationItem.leftBarButtonItem = backButton
        // Create heart button with initial image
        let heartButton = UIBarButtonItem(image: UIImage(systemName: isHeartFilled ? "heart.fill" : "heart"), style: .plain, target: self, action: #selector(heartButtonTapped))
        navigationItem.rightBarButtonItem = heartButton

        // Check if league key exists in the database
        if let leagueId = leagueId, let leagueDetailsViewModel = leagueDetailsViewModel {
            if leagueDetailsViewModel.leagueExists(leagueKey: leagueId) {
                print("League exists in favorites")
                isHeartFilled = true
            } else {
                print("League does not exist in favorites")
                isHeartFilled = false
            }
            // Update heart button's image based on league existence
            heartButton.image = UIImage(systemName: isHeartFilled ? "heart.fill" : "heart")
        } else {
            print("leagueId or leagueDetailsViewModel is nil")
        }


        leagueDetailsViewModel?.bindTeamsLeague = { [weak self] in
                            DispatchQueue.main.async {
                                self?.collectionView.reloadData() 
//                                print(self?.leagueDetailsViewModel?.teams?.first?.team_name ?? "empty")
                            }
            
        }
        leagueDetailsViewModel?.fetchTeams(leagueId: leagueId ?? 0)

        leagueDetailsViewModel?.bindUpcomingEvent = {[weak self] in
            DispatchQueue.main.async {
                self?.upcoming = self?.leagueDetailsViewModel?.upcomingResult
                self?.collectionView.reloadData()
//                print(self?.upcoming?.first?.country_name ?? "no contry name")
            }
            
        }
        leagueDetailsViewModel?.getUpcomingResult(sportName: "football", leagueId: leagueId ?? 0 )
        
        leagueDetailsViewModel?.bindLatestEvent = {[weak self] in
            DispatchQueue.main.async {
                self?.latest = self?.leagueDetailsViewModel?.latestResult
                self?.collectionView.reloadData()
//                print(self?.latest?.first?.event_live ?? "no event live")
            }
            
        }
        leagueDetailsViewModel?.getLatestResult(sportName: "football", leagueId: leagueId ?? 0 )
        
        let upcomingEventsNib = UINib(nibName: "LeaguesUpCommingEventsCollectionViewCell", bundle: nil)
        self.collectionView!.register(upcomingEventsNib, forCellWithReuseIdentifier: reuseIdentifier)
        
        let teamsCellNib = UINib(nibName: "LeaguesTeamsCellCollectionViewCell", bundle: nil)
        self.collectionView!.register(teamsCellNib, forCellWithReuseIdentifier: teamsCellReuseIdentifier)
        
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
    }
    @objc func backButtonTapped() {
           dismiss(animated: true, completion: nil)
       }
    
    @objc func heartButtonTapped() {
        print(leagueId ?? -1)
        print(leagueName ?? "empty leagueName")
        print(leagueLogo ?? "empty leagueLogo")
        
        // Toggle the heart button state
        isHeartFilled.toggle()

        // Update the button appearance based on the state
        let heartImageName = isHeartFilled ? "heart.fill" : "heart"
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: heartImageName)

        // Handle additional actions for the button click
        if isHeartFilled {
            // Add league to favorites
            if let leagueId = leagueId, let leagueName = leagueName {
                // Check if leagueLogo is empty
                let logo = leagueLogo ?? ""
                let leagueLogoToSave = logo.isEmpty ? "https://thumbs.dreamstime.com/b/all-sports-balls-stadium-d-imaginary-sport-modelled-rendered-78672313.jpg" : logo
                leagueDetailsViewModel?.addLeague(leagueName: leagueName, leagueLogo: leagueLogoToSave, leagueKey: leagueId)
            }
        } else {
            // Remove league from favorites
            if let leagueId = leagueId {
                leagueDetailsViewModel?.deleteLeague(leagueKey: leagueId)
            }
        }
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 8 )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
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
        
        // Add header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    func drawTheBottomSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0)
        
        // Add header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return upcoming?.count ?? 1// Assuming one item for the top and bottom sections
        case 1:
            return leagueDetailsViewModel?.teams?.count ?? 0 // Return count of teams array for the second section
        case 2:
            return latest?.count ?? 1
        default:
            fatalError("Unexpected section")
        }
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LeaguesUpCommingEventsCollectionViewCell
            // Configure the custom cell
            // cell.customLabel.text = "Item \(indexPath.row + 1)"
            cell.firstTeamName.text = upcoming?[indexPath.row].event_home_team
            cell.secTeamName.text = upcoming?[indexPath.row].event_away_team
            let imgUrl = URL(string: self.upcoming?[indexPath.row].home_team_logo ?? "")
            cell.firstTeamImage.kf.setImage(with: imgUrl, placeholder: UIImage(named: "barcelona"))
            let imgUrl1 = URL(string: self.upcoming?[indexPath.row].away_team_logo ?? "")
            cell.secTeamImage.kf.setImage(with: imgUrl1, placeholder: UIImage(named: "barcelona"))
            cell.matchDate.text = upcoming?[indexPath.row].event_date
            cell.matchTime.text = upcoming?[indexPath.row].event_time
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamsCellReuseIdentifier, for: indexPath) as! LeaguesTeamsCellCollectionViewCell
            // Configure the custom cell
//            let imageUrl = URL(string: "https://www.freevector.com/uploads/vector/preview/14053/FreeVector-Real-Madrid-FC.jpg")!
//            cell.configure(with: imageUrl)
//            cell.teamName.text = "omar"
            
            if let team = leagueDetailsViewModel?.teams?[indexPath.row] {
                if let imageUrlString = team.team_logo, let imageUrl = URL(string: imageUrlString) {
                    cell.configure(with: imageUrl)
                    cell.teamName.text = team.team_name
//                    print(team.team_name ?? "")
                } else {
                    // Handle missing or invalid image URL
                }
            }

            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LeaguesUpCommingEventsCollectionViewCell
            // Configure the custom cell for the bottom section
            // cell.customLabel.text = "Bottom Item \(indexPath.row + 1)"
            cell.firstTeamName.text = latest?[indexPath.row].event_home_team
            cell.secTeamName.text = latest?[indexPath.row].event_away_team
            let imgUrl = URL(string: self.latest?[indexPath.row].home_team_logo ?? "")
            cell.firstTeamImage.kf.setImage(with: imgUrl, placeholder: UIImage(named: "barcelona"))
            let imgUrl1 = URL(string: self.latest?[indexPath.row].away_team_logo ?? "")
            cell.secTeamImage.kf.setImage(with: imgUrl1, placeholder: UIImage(named: "barcelona"))
            cell.matchDate.text = latest?[indexPath.row].event_date
            cell.matchTime.text = latest?[indexPath.row].event_time
            
            return cell
        default:
            fatalError("Unexpected section")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Unexpected element kind")
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
        switch indexPath.section {
        case 0:
            headerView.label.text = "Upcoming Events"
        case 1:
            headerView.label.text = "Teams"
        case 2:
            headerView.label.text = "Other Events"
        default:
            headerView.label.text = ""
        }
        return headerView
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          if indexPath.section == 1, let team = leagueDetailsViewModel?.teams?[indexPath.row] {
              navigateToTeamDetails(with: team.team_key ?? 0)
              print("click")
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
    
    private func navigateToTeamDetails(with teamKey: Int) {
        let storyboard = UIStoryboard(name: "SecStoryboard", bundle: nil)
        if let teamDetailsVC = storyboard.instantiateViewController(withIdentifier: "TeamDetailCollectionViewController") as? TeamDetailCollectionViewController {
            teamDetailsVC.teamKey = teamKey
            navigationController?.pushViewController(teamDetailsVC, animated: true)
        }
    }
    func createCustomBackButton() -> UIBarButtonItem {
        let backButton = UIButton(type: .system)
        
        // Set the image
        let backImage = UIImage(systemName: "chevron.left")
        backButton.setImage(backImage, for: .normal)
        
        // Set the title
        backButton.setTitle(" Leagues", for: .normal)
        
        // Set the title color (if needed)
        backButton.setTitleColor(UIColor(hex: "#006400", alpha: 0.8), for: .normal)
        
        // Combine the image and title
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        backButton.tintColor = UIColor(hex: "#006400", alpha: 0.8)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        // Create a UIBarButtonItem with the custom button
        let customBarButtonItem = UIBarButtonItem(customView: backButton)
        
        return customBarButtonItem
    }


}

