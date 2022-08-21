//
//  Multi-Entry View.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 19/08/2022.
//
// This View Blueprint will be inherited by Repositories, Users, Commits, Issues and Bookmarks

import UIKit

class MultiEntryView: UIViewController, ViewModelDelegate {
    //MARK: - View Configuration
    weak var coordinator: MainCoordinator?
    var viewModel: ViewModelProtocol?
    var titleImage: UIImage? {
        didSet {
            tabBarItem.image = titleImage
        }
    }
    
    var doesHaveSearchBar: Bool = true
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configureAtViewInit()
    }
    
    func configureAtViewInit() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Elements
    lazy var tableView: UITableView = {
        let myTable = UITableView(frame: .null, style: .grouped)
        myTable.translatesAutoresizingMaskIntoConstraints = false
        myTable.separatorStyle = .singleLine
        myTable.separatorColor = .lightGray
        myTable.estimatedRowHeight = 100
        myTable.rowHeight = UITableView.automaticDimension
        return myTable
    }()

    lazy var requestIndicator: UIActivityIndicatorView = {
        let myIndicator = UIActivityIndicatorView(style: .large)
        myIndicator.hidesWhenStopped = true
        myIndicator.startAnimating()
        return myIndicator
    }()
    
    lazy var searchController = UISearchController()
    
    lazy var longPressGesture = UILongPressGestureRecognizer(target: self, action: nil)
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        searchController.searchResultsUpdater = self
        
        // UISearchController
        if doesHaveSearchBar {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        }
        
        Task {
            do {
                try await viewModel?.start()
            } catch {
                presentError(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        // UITableView Configuration
        view.addSubview(tableView)
        NSLayoutConstraint.activate(
            [tableView.topAnchor.constraint(equalTo: view.topAnchor),
             tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
        
        // UILongPressGestureRecognizer Configuration
        tableView.addGestureRecognizer(longPressGesture)
        
        // UIActivityIndicator Configuration
        view.addSubview(requestIndicator)
        requestIndicator.center = view.center
        

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            try CoreDataHelper.shared.load()
        } catch {
            print(error.localizedDescription)
        }
        if let tabBar = self.tabBarController {
            tabBar.navigationItem.title = title
        }
        tableView.reloadData()
    }
    
    func presentError(_ error: Error) {
        let errorMessage = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .actionSheet)
        errorMessage.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(errorMessage, animated: true)
    }
       
    
    //MARK: - ViewModelDelegate Methods
    func didUpdateDataModel() {
        DispatchQueue.main.async {
            self.requestIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
}

//MARK: - UISearchResultsUpdating

extension MultiEntryView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension MultiEntryView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = viewModel as? BookmarksViewModel {
            switch section {
            case 0: return viewModel.repos.count
            case 1: return viewModel.users.count
            default: return 0
            }
        } else {
            return viewModel?.itemCount ?? 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel is BookmarksViewModel {
            return 2
        } else {
            return 1
        }
    }
}

extension MultiEntryView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
