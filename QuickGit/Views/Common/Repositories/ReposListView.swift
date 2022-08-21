//
//  ReposListView.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 21/08/2022.
//

import UIKit

class ReposListView: MultiEntryView {
    override func configureAtViewInit() {
        title = "Repositories"
        viewModel = RepositoriesViewModel()
    }
    
    override func viewDidLoad() {
        tableView.register(CompactRepoCell.self, forCellReuseIdentifier: "repo")
        super.viewDidLoad()
    }
}

extension ReposListView {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let cell = tableView.cellForRow(at: indexPath)!
        let viewModel = viewModel as! RepositoriesViewModel
        
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
                    try await (viewModel as! RepositoriesViewModel).fetchNextEntries()
                } catch {
                    presentError(error)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repo", for: indexPath)
        (viewModel as! RepositoriesViewModel).configure(cell, at: indexPath)
        return cell
    }
    
    override func updateSearchResults(for searchController: UISearchController) {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        Task {
            do {
                try await (viewModel as! RepositoriesViewModel).search(for: searchController.searchBar.text ?? "")
            } catch {
                presentError(error)
            }
        }
    }
}

extension ReposListView {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.goToCommitsView((viewModel as! RepositoriesViewModel).dataModel[indexPath.row].repoName)
        super.tableView(tableView, didSelectRowAt: indexPath)
    }
}

