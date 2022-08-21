//
//  CompactUserCell.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 12/08/2022.
//

import UIKit
import Kingfisher

class CompactUserCell: UITableViewCell {
    
    //MARK: - Cell Data Model
    var cellModel: UserModel? {
        didSet {
            userLabel.text = cellModel?.userName
            userImage.kf.setImage(with: URL(string: cellModel!.avatarURL))
        }
    }
    
    //MARK: - UI Elements Initialization
    let userImage = UIImageView()
    let userLabel = UILabel()
    
    //MARK: - Life Cycle
    
    override func layoutSubviews() {
        setupView()
    }

    //MARK: - UI Elements Setup
    
    func setupView() {
        userImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(userImage)

        userImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
        userImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

//        userImage.image = UIImage(named: "me")
        userImage.layer.cornerRadius = 25
        userImage.clipsToBounds = true
        
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(userLabel)
        userLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        userLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 24).isActive = true
        userLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
       
//        userLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 24).isActive = true
        
        contentView.sizeToFit()
    }
}
