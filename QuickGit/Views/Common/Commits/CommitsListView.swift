//
//  CommitsListView.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 21/08/2022.
//

import UIKit

class CommitsListView: MultiEntryView {
    override func configureAtViewInit() {
        title = "Commits"
//        viewModel = CommitViewModel()
        doesHaveSearchBar = false
    }
    
    override func viewDidLoad() {
        tableView.register(CommitCell.self, forCellReuseIdentifier: "commit")
        super.viewDidLoad()
    }
}

extension CommitsListView {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let cell = tableView.cellForRow(at: indexPath)!
        let viewModel = viewModel as! CommitViewModel
        
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
                    try await (viewModel as! CommitViewModel).fetchNextEntries()
                } catch {
                    presentError(error)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commit", for: indexPath)
        (viewModel as! CommitViewModel).configure(cell, at: indexPath)
        return cell
    }
}
