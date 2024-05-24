//
//  HomeCollectionViewCell.swift
//  SportsApp
//
//  Created by Yomna Magdy  on 5/16/24.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            setupUI()
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
