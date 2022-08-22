//
//  SearchSuggestionsView.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 22/08/2022.
//

import UIKit

class SearchSuggestionsView: UIViewController {
    weak var coordinator: MainCoordinator?
    lazy var tableView: UITableView = {
        let myTable = UITableView(frame: .zero, style: .grouped)
        myTable.translatesAutoresizingMaskIntoConstraints = false
        return myTable
    }()
    
    var query: String? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewDidLayoutSubviews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
}

extension SearchSuggestionsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Search for \(query ?? "") in Users"
            cell.imageView?.image = UIImage(systemName: "person")
        case 1:
            cell.textLabel?.text = "Search for \(query ?? "") in Repositories"
            cell.imageView?.image = UIImage(systemName: "book.closed")
        default: break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0: coordinator?.searchUsersWithQuery(query ?? "")
            case 1: coordinator?.searchReposWithQuery(query ?? "")
            default: break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
