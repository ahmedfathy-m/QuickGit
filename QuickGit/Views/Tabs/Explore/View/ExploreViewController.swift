//
//  ExploreViewController.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 17/08/2022.
//

import UIKit

class ExploreViewController: UIViewController {
    let tableView = UITableView()
    let handler = ExploreTableHandler()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.title = "Explore"
        self.tabBarItem.image = UIImage(systemName: "binoculars.fill")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ExploreTableCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = handler
        tableView.delegate = handler
        view.addSubview(tableView)
        NSLayoutConstraint.activate(
            [tableView.topAnchor.constraint(equalTo: view.topAnchor),
             tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)]
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Explore"
    }
}
