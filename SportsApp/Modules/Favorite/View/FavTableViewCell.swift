//
//  FavTableViewCell.swift
//  SportsApp
//
//  Created by Yomna Magdy  on 5/18/24.
//

import UIKit

class FavTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var badge: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        badge.layer.cornerRadius = badge.frame.size.width / 2
                badge.clipsToBounds = true
                badge.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
