//
//  UsersListView.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 21/08/2022.
//

import UIKit

class UsersListView: MultiEntryView {
    override func configureAtViewInit() {
        title = "Users"
        viewModel = UsersViewModel()
    }
    
    override func viewDidLoad() {
        tableView.register(CompactUserCell.self, forCellReuseIdentifier: "user")
        super.viewDidLoad()
    }
}

extension UsersListView {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let cell = tableView.cellForRow(at: indexPath)!
        let viewModel = viewModel as! UsersViewModel
        
        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            return UIMenu(title: "Options", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: viewModel.fetchChildActions(for: cell, at: indexPath))
        }
        return context
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row > tableView.numberOfRows(inSection: 0) - 2 else { return }
        if indexPath.row > tableView.numberOfRows(inSection: 0) - 2 {
            
            Task {
                do {
                    try await (viewModel as! UsersViewModel).fetchNextEntries()
                } catch {
                    presentError(error)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath)
        (viewModel as! UsersViewModel).configure(cell, at: indexPath)
        return cell
    }
    
    override func updateSearchResults(for searchController: UISearchController) {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        Task {
            do {
                try await (viewModel as! UsersViewModel).search(for: searchController.searchBar.text ?? "")
            } catch {
                presentError(error)
            }
        }
    }
}

extension UsersListView {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.goToUser(with: (viewModel as! UsersViewModel).dataModel[indexPath.row].userName)
        super.tableView(tableView, didSelectRowAt: indexPath)
    }
}
