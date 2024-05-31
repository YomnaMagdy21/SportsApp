//
//  FavTableViewCell.swift
//  SportsApp
//
//  Created by Yomna Magdy  on 5/17/24.
//

import UIKit

class TableViewCell: UITableViewCell {


    @IBOutlet weak var imgLeague: UIImageView!
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var TitleLeague: UILabel!
    private let containerView = UIView()
       
       override func awakeFromNib() {
           super.awakeFromNib()
          // setupUI()
           
            DispatchQueue.main.async {
                self.imgLeague.layer.cornerRadius = self.imgLeague.frame.size.height / 2
                self.imgLeague.clipsToBounds = true
                self.imgLeague.contentMode = .scaleAspectFill
                
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
