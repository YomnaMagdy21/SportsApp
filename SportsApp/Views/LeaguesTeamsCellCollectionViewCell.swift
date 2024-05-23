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
        setupUI()

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
    private func setupUI() {
         // Set border color and width
        self.layer.borderColor = UIColor(hex: "#006400", alpha: 0.8).cgColor
         self.layer.borderWidth = 1.0
         
         // Set corner radius
         self.layer.cornerRadius = 10.0
         
         // Clip to bounds to apply the corner radius
         self.clipsToBounds = true
     }

}
