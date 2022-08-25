//
//  RecentSearchHeader.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 22/08/2022.
//

import UIKit

class RecentSearchHeader: UITableViewHeaderFooterView {
    static let identifier = "recents"
    let viewModel = RecentlyVisitedViewModel()
    
    lazy var titleLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "Recent"
        myLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        myLabel.textColor = .gray
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        return myLabel
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 70, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let myCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myCollection.showsHorizontalScrollIndicator = false
        myCollection.translatesAutoresizingMaskIntoConstraints = false
        myCollection.dataSource = self
        myCollection.delegate = self
        myCollection.register(LastSearchCard.self, forCellWithReuseIdentifier: "last")
        return myCollection
    }()
    
    lazy var clearButton: UIButton = {
        let myButton = UIButton()
        myButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.addTarget(self, action: #selector(clearDataAction), for: .touchUpInside)
        return myButton
    }()
    
    var deleteAction = {
        
    }
    
    @objc fileprivate func clearDataAction() {
        deleteAction()
    }
    
    var cellTapAction: (_ username: String) -> () = { username in
        
    }
       
    override func layoutSubviews() {
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
                                     titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                                     titleLabel.heightAnchor.constraint(equalToConstant: 20)])
        
        self.addSubview(clearButton)
        NSLayoutConstraint.activate([clearButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                                     clearButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)])
        
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
                                     collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     collectionView.heightAnchor.constraint(equalToConstant: 120)])
    }
}


extension RecentSearchHeader: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "last", for: indexPath) as! LastSearchCard
        viewModel.configure(cell, at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! LastSearchCard
        if let userName = cell.userLabel.text {
            cellTapAction(userName)
        }
    }
    
}
