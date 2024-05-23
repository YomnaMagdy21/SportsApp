//
//  TeamDetailsTopSectionCollectionViewCell.swift
//  SportsApp
//
//  Created by Omar  on 18/05/2024.
//

import UIKit

class TeamDetailsTopSectionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var teamImage: UIImageView!
    
    func configure(with teamName: String?, logoUrl: String?) {
        self.teamName.text = teamName
        
        if let logoUrl = logoUrl, let url = URL(string: logoUrl) {
            self.teamImage.kf.setImage(with: url)
        } else {
            self.teamImage.image = (.barcelona) // Set a placeholder image if needed
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
