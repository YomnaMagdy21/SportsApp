//
//  LeaguesTeamsCellCollectionViewCell.swift
//  SportsApp
//
//  Created by Omar  on 17/05/2024.
//

import UIKit
import Kingfisher

class LeaguesTeamsCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Make the image view circular
        teamImage.layer.cornerRadius = teamImage.frame.size.height / 2
//        teamImage.layer.cornerRadius = teamImage.frame.size.width / 2
        teamImage.clipsToBounds = true
    }
    
    func configure(with imageUrl: URL) {
        // Load image using Kingfisher
        let placeholderImage = UIImage(named: "barcelona") 
               teamImage.kf.setImage(with: imageUrl, placeholder: placeholderImage)
    }

}
