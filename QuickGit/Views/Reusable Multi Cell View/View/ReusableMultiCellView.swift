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
        switch contentType {
        case .users(let pageType): viewModel = UserSearchViewModel(type: pageType)
        case .repos(let pageType): viewModel = ReposViewModel(type: pageType)
        case .commits: viewModel = CommitsViewModel(repo: contentType.targetRepo)
        case .bookmarks: break
        }
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
        myTableView.estimatedRowHeight = 100
        myTableView.rowHeight = UITableView.automaticDimension
        return myTableView
    }()
    lazy var handler = ReusableTableViewTableHandler(contentType: contentType)
    let searchController = UISearchController(searchResultsController: RecentSearchViewController())
    var viewModel: ViewModelProtocol?
    
    
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
        viewModel?.delegate = self
        
        Task {
            do {
                try await viewModel?.start()
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
        
        searchController.showsSearchResultsController = true
    }
}

extension ReusableMultiCellView: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text?.count ?? 0 > 0 {
            searchController.showsSearchResultsController = false
            switch contentType {
                case .users:
                let viewModel = viewModel as! UserSearchViewModel
                Task {
                    try await viewModel.search(query: searchController.searchBar.text!)
                }
                case .repos(_): break
                case .commits(_): break
                case .bookmarks: break
                }
        } else {
            searchController.showsSearchResultsController = true
            switch contentType {
                case .users:
                let viewModel = viewModel as! UserSearchViewModel
                viewModel.restoreDataModel()
                case .repos(_): break
                case .commits(_): break
                case .bookmarks: break
                }
        }
    }
}

//MARK: - Navigation

extension ReusableMultiCellView {
    func goToUsersRepos() {
        coordinator?.goToReposSearch()
    }
    
    func goToUserCommits(_ targetRepo: String) {
        coordinator?.goToCommitsView(targetRepo)
    }
    
    func goToUser(with name: String?) {
        coordinator?.goToUser(with: name)
    }
}


extension ReusableMultiCellView: ViewModelDelegate {
    func didUpdateDataModel() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
