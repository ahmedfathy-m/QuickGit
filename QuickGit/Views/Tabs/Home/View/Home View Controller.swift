//
//  ViewController.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 10/08/2022.
//

import UIKit

class HomeViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    //MARK: - UI Initialization
    
    let tableView: UITableView = {
        let myTableView = UITableView(frame: .null, style: .insetGrouped)
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        return myTableView
    }()
    let tableViewHandler = HomeTableViewHandler()
    let viewModel = HomeViewModel()
    let searchController = UISearchController()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        searchController.searchResultsUpdater = self
        self.title = "Home"
        self.tabBarItem.image = UIImage(systemName: "house.fill")
        
        tabBarController?.navigationItem.searchController = searchController
        tabBarController?.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "Home"
        let settingsButton = UIButton()
        settingsButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsPressed), for: .touchUpInside)
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
    }
    
    override func viewDidLayoutSubviews() {
        setUpTableView()
    }
    
    //MARK: - UI Actions
    func usersButtonPressed() {
        coordinator?.goToUserSearch()
    }
    
    func repoButtonPressed() {
        coordinator?.goToReposSearch()
    }
    
    @objc func settingsPressed() {
        coordinator?.goToSettings()
    }
}

extension HomeViewController {
    fileprivate func setUpTableView() {
        tableView.dataSource = tableViewHandler
        tableView.delegate = tableViewHandler
        tableViewHandler.superView = self
        tableView.register(OptionCell.nib(), forCellReuseIdentifier: OptionCell.identifier)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}


