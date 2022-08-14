//
//  ReusableMultiCellView.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 12/08/2022.
//

import UIKit

class ReusableMultiCellView: UIViewController {
    weak var coordinator: MainCoordinator?
    
    //MARK: - Class Initializer
    var contentType: ContentType
    init(contentType: ContentType) {
        self.contentType = contentType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Elements
    
    let tableView: UITableView = {
        let myTableView = UITableView(frame: .null, style: .grouped)
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.separatorStyle = .singleLine
        myTableView.separatorColor = .lightGray
        return myTableView
    }()
    lazy var handler = ReusableTableViewTableHandler(contentType: contentType)
    let searchController = UISearchController(searchResultsController: RecentSearchViewController())
    let viewModel = UserSearchViewModel()
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch contentType {
        case .users: tableView.register(CompactUserCell.self, forCellReuseIdentifier: "compactUserCell")
        case .repos: tableView.register(CompactRepoCell.self, forCellReuseIdentifier: "compactRepoCell")
        case .bookmarks:
            tableView.register(CompactUserCell.self, forCellReuseIdentifier: "compactUserCell")
            tableView.register(CompactRepoCell.self, forCellReuseIdentifier: "compactRepoCell")
        case .commits: tableView.register(CommitCell.self, forCellReuseIdentifier: "commitCell")
        }
        configureSearchController()
        viewModel.delegate = self
        
        Task {
            do {
                try await viewModel.initializeViewModel()
            } catch {
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        setupTableView()
    }
    
    //MARK: - UI Setup
    func setupTableView() {
        tableView.dataSource = handler
        tableView.delegate = handler
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    //MARK: - Search Setup
    fileprivate func configureSearchController() {
        searchController.searchResultsUpdater = self
        view.addSubview(UIView(frame: .zero))
        searchController.searchBar.searchTextField.backgroundColor = .lightGray.withAlphaComponent(0.4)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func didUpdateDataModel() {
        DispatchQueue.main.async {
            print("Got em")
            self.tableView.reloadData()
        }
    }
}

extension ReusableMultiCellView: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

//MARK: - Navigation

extension ReusableMultiCellView {
    func goToUsersRepos() {
        coordinator?.goToReposSearch()
    }
    
    func goToUserCommits() {
        coordinator?.goToCommitsView()
    }
    
    func goToUser(with name: String?) {
        coordinator?.goToUser(with: name)
    }
}
