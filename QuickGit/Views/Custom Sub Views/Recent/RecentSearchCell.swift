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
    lazy var recentQueryLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        return myLabel
    }()
    
    let reuseQueryButton = UIButton()
    
    lazy var reuseQueryIcon:UIImageView = {
        let myImage = UIImageView()
        myImage.translatesAutoresizingMaskIntoConstraints = false
        myImage.image = UIImage(systemName: "arrow.up.left")
        myImage.contentMode = .scaleAspectFill
        return myImage
    }()
    
    lazy var historyIcon:UIImageView = {
       let myImage = UIImageView()
        myImage.translatesAutoresizingMaskIntoConstraints = false
        myImage.image = UIImage(systemName: "clock")
        return myImage
    }()
    
    //MARK: - UI Setup
    override func layoutSubviews() {
        self.backgroundColor = .clear
        
        contentView.addSubview(historyIcon)
        NSLayoutConstraint.activate([historyIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                     historyIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                                     historyIcon.widthAnchor.constraint(equalToConstant: 20),
                                     historyIcon.heightAnchor.constraint(equalToConstant: 20)])
        
        contentView.addSubview(recentQueryLabel)
        NSLayoutConstraint.activate([recentQueryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                     recentQueryLabel.leadingAnchor.constraint(equalTo: historyIcon.trailingAnchor, constant: 12)])
        
        contentView.addSubview(reuseQueryIcon)
        NSLayoutConstraint.activate([reuseQueryIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                     reuseQueryIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                                     reuseQueryIcon.widthAnchor.constraint(equalToConstant: 20),
                                     reuseQueryIcon.heightAnchor.constraint(equalToConstant: 20)])


    }
}
