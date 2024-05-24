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
    private let containerView = UIView()
       
       override func awakeFromNib() {
           super.awakeFromNib()
           setupUI()
       }

       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
       }

       private func setupUI() {
           
           containerView.translatesAutoresizingMaskIntoConstraints = false
           contentView.addSubview(containerView)
           
           
           NSLayoutConstraint.activate([
               containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
               containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
               containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
               containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
           ])
           
          
           containerView.addSubview(TitleLeague)
           
          
           TitleLeague.translatesAutoresizingMaskIntoConstraints = false

           NSLayoutConstraint.activate([
              
            TitleLeague.leadingAnchor.constraint(equalTo: imgLeague.trailingAnchor, constant: 10),
            TitleLeague.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            TitleLeague.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
           ])
           
          
           DispatchQueue.main.async {
               self.imgLeague.layer.cornerRadius = self.imgLeague.frame.size.height / 2
               self.imgLeague.clipsToBounds = true
               self.imgLeague.contentMode = .scaleAspectFill
               
           }

          
           containerView.layer.cornerRadius = 10
           containerView.layer.borderWidth = 1.0
           containerView.layer.borderColor = UIColor(hex: "#006400", alpha: 0.8).cgColor
           containerView.clipsToBounds = true
       }

}
