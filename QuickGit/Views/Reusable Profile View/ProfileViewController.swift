//
//  ProfileViewController.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 13/08/2022.
//

import UIKit

class ProfileViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    var viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - UI Elements
    let tableView = UITableView(frame: .null, style: .grouped)
    let handler = ProfileTableHandler()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(OptionCell.nib(), forCellReuseIdentifier: OptionCell.identifier)
        tableView.register(UserHeaderView.nib(), forHeaderFooterViewReuseIdentifier: UserHeaderView.identifier)
        tableView.dataSource = handler
        tableView.delegate = handler
        
        Task {
            do {
                try await viewModel.start()
            } catch {
                print(error)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "Profile"
    }
    
    override func viewDidLayoutSubviews() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    //MARK: - Navigation
    func goToUsersRepos() {
        coordinator?.goToReposSearch()
    }
    
    func didUpdateDataModel() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
