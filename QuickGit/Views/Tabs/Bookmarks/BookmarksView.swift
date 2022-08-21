//
//  BookmarksView.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 19/08/2022.
//

import UIKit

class BookmarksView: MultiEntryView {
    
    override func configureAtViewInit() {
        title = "Bookmarks"
        titleImage = UIImage(systemName: "bookmark.fill")
        viewModel = BookmarksViewModel()
        requestIndicator.stopAnimating()
    }
    
    override func viewDidLoad() {
        tableView.register(CompactUserCell.self, forCellReuseIdentifier: "user")
        tableView.register(CompactRepoCell.self, forCellReuseIdentifier: "repo")
        super.viewDidLoad()
    }
}

extension BookmarksView {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "repo", for: indexPath) as! CompactRepoCell
            cell.backgroundColor = .clear
            (viewModel as! BookmarksViewModel).configure(cell: cell, at: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! CompactUserCell
            cell.backgroundColor = .clear
            (viewModel as! BookmarksViewModel).configure(cell: cell, at: indexPath)
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 103
        case 1: return 70
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Repositories"
        case 1: return "Users"
        default: return nil
        }
    }
    

    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let cell = tableView.cellForRow(at: indexPath)!
        let viewModel = viewModel as! BookmarksViewModel
        
        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            return UIMenu(title: "Options", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: viewModel.fetchChildActions(for: cell, at: indexPath))
        }
        return context
    }
}
