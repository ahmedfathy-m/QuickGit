//
//  CommitCell.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 13/08/2022.
//

import UIKit

class CommitCell: UITableViewCell {
    
    //MARK: - UI Initialization
    let committerName = UILabel()
    let committerImage = UIImageView()
    let commit = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        self.separatorInset = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Layout
    override func layoutSubviews() {
        //CommitterImage
        committerImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(committerImage)
        committerImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        committerImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        committerImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        committerImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        committerImage.layer.cornerRadius = 15
        committerImage.clipsToBounds = true
        committerImage.image = UIImage(named: "me")
        
        //CommitterName Label
        committerName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(committerName)
        committerName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        committerName.leadingAnchor.constraint(equalTo: committerImage.trailingAnchor, constant: 10).isActive = true
        committerName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //Commit Label
        commit.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(commit)
        commit.topAnchor.constraint(equalTo: committerName.bottomAnchor, constant: 10).isActive = true
        commit.heightAnchor.constraint(equalToConstant: 20).isActive = true
        commit.leadingAnchor.constraint(equalTo: committerName.leadingAnchor).isActive = true
        
    }
}
