//
//  RecentSearchViewController.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 13/08/2022.
//

import UIKit

class RecentSearchViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    lazy var tableView: UITableView = {
        let myTable = UITableView(frame: .null, style: .grouped)
        myTable.translatesAutoresizingMaskIntoConstraints = false
        return myTable
    }()
    
    let viewModel = RecentQueriesViewModel()
    
    var isSearchingForUsers = true
    
    var queryTapAction: (_ query: String) -> () = {query in
        
    }
    
    override func viewDidLoad() {
        tableView.register(RecentSearchCell.self, forCellReuseIdentifier: "query")
        tableView.register(RecentSearchHeader.self, forHeaderFooterViewReuseIdentifier: RecentSearchHeader.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
}


extension RecentSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemCount
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: RecentSearchHeader.identifier) as! RecentSearchHeader
        if header.viewModel.itemCount == 0 {
            isSearchingForUsers = false
        }
        header.collectionView.reloadData()
        header.cellTapAction = { username in
            self.coordinator?.goToUser(with: username)
        }
        header.deleteAction = {
            do {
                try CoreDataHelper.shared.clearHistory()
            } catch {
                print(error.localizedDescription)
            }
            tableView.reloadData()
            header.collectionView.reloadData()
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isSearchingForUsers {
            return 160
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "query", for: indexPath) as! RecentSearchCell
        viewModel.configure(cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RecentSearchCell
        queryTapAction(cell.recentQueryLabel.text ?? "")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
