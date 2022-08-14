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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "Home"
        let settingsButton = UIButton()
        settingsButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsPressed), for: .touchUpInside)
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
    }
    
    override func viewDidLayoutSubviews() {
        view.addSubview(UIView(frame: .zero))
        searchController.searchBar.searchTextField.backgroundColor = .lightGray.withAlphaComponent(0.4)
        tabBarController?.navigationItem.searchController = searchController
        tabBarController?.navigationItem.hidesSearchBarWhenScrolling = false
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
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}


