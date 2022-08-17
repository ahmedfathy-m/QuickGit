//
//  LastSearchCard.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 13/08/2022.
//

import UIKit

class LastSearchCard: UICollectionViewCell {
    //MARK: - UI Elements
    let userImage = UIImageView()
    let userLabel = UILabel()
    
    //MARK: - UI Setup
    override func layoutSubviews() {
        userImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(userImage)
        userImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        userImage.layer.cornerRadius = 25
        userImage.clipsToBounds = true
        
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(userLabel)
        userLabel.font = UIFont.systemFont(ofSize: 14)
        userLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        userLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 15).isActive = true
        userLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
