//
//  CompactRepoCell.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 13/08/2022.
//

import UIKit

class CompactRepoCell: UITableViewCell {
    
    //MARK: - Cell Data Configuration
    
    var repoName: String? {
        didSet {
            titleLabel.text = repoName
        }
    }
    //MARK: - UI Elements
    
    private let titleLabel = UILabel()
    private let aboutLabel = UILabel()
    private let starCount = UILabel()
    private let usedLang = UILabel()
    private let starSymbol = UIImageView()
    private let langCircle = UIView()
    
    //MARK: - Life Cycle
    
    override func layoutSubviews() {
        setupView()
    }
    
    //MARK: - View Setup Functions
    
    func setupView() {
        //titleLabel Setup
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        titleLabel.text = "Repo name"
        
        //AboutLabel Setup
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(aboutLabel)
        aboutLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        aboutLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        aboutLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        aboutLabel.text = "Repo Description"
        
        //StarSymbol Setup
        starSymbol.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(starSymbol)
        starSymbol.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 10).isActive = true
        starSymbol.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        starSymbol.widthAnchor.constraint(equalToConstant: 21).isActive = true
        starSymbol.heightAnchor.constraint(equalToConstant: 21).isActive = true
        starSymbol.image = UIImage(systemName: "star.fill")
        starSymbol.tintColor = .systemYellow
        
        //StarCount Setup
        starCount.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(starCount)
        starCount.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 10).isActive = true
        starCount.leadingAnchor.constraint(equalTo: starSymbol.trailingAnchor, constant: 10).isActive = true
        starCount.heightAnchor.constraint(equalToConstant: 21).isActive = true
        starCount.text = "453536"
        
        //LangIcon Setup
        langCircle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(langCircle)
        langCircle.leadingAnchor.constraint(equalTo: starCount.trailingAnchor, constant: 24).isActive = true
        langCircle.widthAnchor.constraint(equalToConstant: 21).isActive = true
        langCircle.heightAnchor.constraint(equalToConstant: 21).isActive = true
        langCircle.centerYAnchor.constraint(equalTo: starCount.centerYAnchor).isActive = true
        langCircle.backgroundColor = .systemRed
        langCircle.layer.cornerRadius = 11.5
        
        //usedLang Setup
        usedLang.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(usedLang)
        usedLang.leadingAnchor.constraint(equalTo: langCircle.trailingAnchor, constant: 10).isActive = true
        usedLang.centerYAnchor.constraint(equalTo: starCount.centerYAnchor).isActive = true
        usedLang.heightAnchor.constraint(equalToConstant: 21).isActive = true
        usedLang.text = "Swift"
        
        contentView.sizeToFit()
    }
}
