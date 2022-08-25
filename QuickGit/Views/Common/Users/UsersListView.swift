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
}

extension UsersListView {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newUser = RecentSearchUser(context: CoreDataHelper.shared.context!)
        let model = tableView.cellForRow(at: indexPath) as! CompactUserCell
        newUser.userName = model.userLabel.text
        newUser.image = model.userImage.image?.jpegData(compressionQuality: 0.8)
        CoreDataHelper.shared.recentSearchedUsers.append(newUser)
        do {
            try CoreDataHelper.shared.context?.save()
        } catch {
            print(error.localizedDescription)
        }
        coordinator?.goToUser(with: (viewModel as! UsersViewModel).dataModel[indexPath.row].userName)
        super.tableView(tableView, didSelectRowAt: indexPath)
    }
}

//MARK: - SearchController Configurations

extension UsersListView {
    override func updateSearchResults(for searchController: UISearchController) {
        resultsController.queryTapAction = { query in
            searchController.searchBar.text = query
        }
        searchController.showsSearchResultsController = true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func triggerSearchAction(using searchBar: UISearchBar) {
        if !(searchBar.text!.isEmpty) {
            Task {
                do {
                    try await (viewModel as! UsersViewModel).search(for: searchController.searchBar.text ?? "")
                } catch {
                    presentError(error)
                }
            }
            let newQuery = RecentSearchQuery(context: CoreDataHelper.shared.context!)
            newQuery.query = searchBar.text
            CoreDataHelper.shared.recentQueries.append(newQuery)
            do {
                try CoreDataHelper.shared.context?.save()
            } catch {
                print(error.localizedDescription)
            }
            searchController.showsSearchResultsController = false
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        triggerSearchAction(using: searchBar)
    }
    
    
}
