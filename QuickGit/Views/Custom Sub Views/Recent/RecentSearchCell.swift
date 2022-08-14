//
//  RecentSearchCell.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 13/08/2022.
//

import UIKit

class RecentSearchCell: UITableViewCell {
    //MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Elements
    let recentQueryLabel = UILabel()
    let reuseQueryButton = UIButton()
    let reuseQueryImage = UIImageView()
    
    //MARK: - UI Setup
    override func layoutSubviews() {
        recentQueryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(recentQueryLabel)
        recentQueryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        recentQueryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        
        reuseQueryImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(reuseQueryImage)
        reuseQueryImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        reuseQueryImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
        reuseQueryImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        reuseQueryImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        reuseQueryImage.image = UIImage(systemName: "arrow.up.left")
        reuseQueryImage.contentMode = .scaleAspectFill
//        reuseQueryImage.tintColor = .blue
        
        contentView.sizeToFit()
    }
}
