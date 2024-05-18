//
//  FavTableViewCell.swift
//  SportsApp
//
//  Created by Yomna Magdy  on 5/17/24.
//

import UIKit

class TableViewCell: UITableViewCell {


    @IBOutlet weak var imgLeague: UIImageView!
    
    @IBOutlet weak var TitleLeague: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgLeague.layer.cornerRadius = imgLeague.frame.size.width / 2
        imgLeague.clipsToBounds = true
        imgLeague.contentMode = .scaleAspectFill
        

        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
