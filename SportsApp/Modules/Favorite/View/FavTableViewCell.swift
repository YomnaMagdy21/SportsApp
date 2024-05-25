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
           
          
           containerView.addSubview(name)
           
           
           name.translatesAutoresizingMaskIntoConstraints = false

           NSLayoutConstraint.activate([
              
               name.leadingAnchor.constraint(equalTo: badge.trailingAnchor, constant: 10),
               name.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
               name.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
           ])
           
          
           DispatchQueue.main.async {
               self.badge.layer.cornerRadius = self.badge.frame.size.width / 2
               self.badge.clipsToBounds = true
               self.badge.contentMode = .scaleAspectFill
               
           }

           
           containerView.layer.cornerRadius = 10
           containerView.layer.borderWidth = 1.0
           containerView.layer.borderColor = UIColor(hex: "#006400", alpha: 0.8).cgColor
           containerView.clipsToBounds = true
       }
}
