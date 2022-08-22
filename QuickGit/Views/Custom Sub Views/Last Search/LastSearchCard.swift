//
//  LastSearchCard.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 13/08/2022.
//

import UIKit

class LastSearchCard: UICollectionViewCell {
    //MARK: - UI Elements
    lazy var userImage: UIImageView = {
        let myImage = UIImageView()
        myImage.translatesAutoresizingMaskIntoConstraints = false
        myImage.layer.cornerRadius = 25
        myImage.clipsToBounds = true
        return myImage
    }()
    
    lazy var userLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.font = UIFont.systemFont(ofSize: 14)
        myLabel.textAlignment = .center
        myLabel.numberOfLines = 0
        return myLabel
    }()
    
    //MARK: - UI Setup
    override func layoutSubviews() {
        contentView.addSubview(userImage)
        NSLayoutConstraint.activate([userImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                     userImage.widthAnchor.constraint(equalToConstant: 50),
                                     userImage.heightAnchor.constraint(equalToConstant: 50),
                                     userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)])

        
        contentView.addSubview(userLabel)
        NSLayoutConstraint.activate([userLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                     userLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 5),
//                                     userLabel.heightAnchor.constraint(equalToConstant: 20),
                                     userLabel.widthAnchor.constraint(equalToConstant: 50)])
    }
}
