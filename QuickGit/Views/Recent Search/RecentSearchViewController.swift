//
//  RecentSearchViewController.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 13/08/2022.
//

import UIKit

class RecentSearchViewController: UIViewController {
    let lastSearchLabel = UILabel()
    let recentQueryLabel = UILabel()
    let collectionView = UICollectionView(frame: .null, collectionViewLayout: UICollectionViewLayout())
    let tableView = UITableView(frame: .null, style: .plain)
    
    let collectionHandler = CollectionViewHandler()
    let tableHandler = TableViewHandler()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(LastSearchCard.self, forCellWithReuseIdentifier: "searchCard")
        collectionView.dataSource = collectionHandler
        collectionView.delegate = collectionHandler
        tableView.register(RecentSearchCell.self, forCellReuseIdentifier: "recentSearch")
        tableView.dataSource = tableHandler
        tableView.delegate = tableHandler
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        lastSearchLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lastSearchLabel)
        lastSearchLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        lastSearchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        lastSearchLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lastSearchLabel.text = "LAST SEARCH"
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: lastSearchLabel.bottomAnchor, constant: 15).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        recentQueryLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recentQueryLabel)
        recentQueryLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 15).isActive = true
        recentQueryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        recentQueryLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        recentQueryLabel.text = "RECENT SEARCH"
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: recentQueryLabel.bottomAnchor, constant: 15).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
