//
//  LeaguesUpCommingEventsCollectionViewCell.swift
//  SportsApp
//
//  Created by Omar  on 17/05/2024.
//

import UIKit

class LeaguesUpCommingEventsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var firstTeamImage: UIImageView!
    
    @IBOutlet weak var firstTeamName: UILabel!
    @IBOutlet weak var secTeamImage: UIImageView!
    @IBOutlet weak var secTeamName: UILabel!
    @IBOutlet weak var matchDate: UILabel!
    @IBOutlet weak var matchTime: UILabel!
    
    @IBOutlet weak var result: UILabel!
    let imgView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //adding commient
        setupUI()
//        
//        imgView.frame = CGRect(x: 1, y: 40, width: frame.width, height: frame.height - 40)
//        addSubview(imgView)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)

        imgView.frame = CGRect(x: 1, y: 40, width: frame.width, height: frame.height - 40)
        addSubview(imgView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
