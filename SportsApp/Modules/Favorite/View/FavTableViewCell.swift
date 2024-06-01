//
//  FavTableViewCell.swift
//  SportsApp
//
//  Created by Yomna Magdy  on 5/18/24.
//

import UIKit

class FavTableViewCell: UITableViewCell {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var badge: UIImageView!
    private let containerView = UIView()
       
       override func awakeFromNib() {
           super.awakeFromNib()
          // setupUI()
           
            DispatchQueue.main.async {
                self.badge.layer.cornerRadius = self.badge.frame.size.width / 2
                self.badge.clipsToBounds = true
                self.badge.contentMode = .scaleAspectFill
                
            }

            
           myView.layer.cornerRadius = 10
           myView.layer.borderWidth = 1.0
           myView.layer.borderColor = UIColor(hex: "#006400", alpha: 0.8).cgColor
           myView.clipsToBounds = true
        
       }

       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
       }

      
}
