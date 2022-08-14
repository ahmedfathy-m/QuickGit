//
//  ReusableTableViewTableHandler.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 12/08/2022.
//

import UIKit

class ReusableTableViewTableHandler: NSObject, UITableViewDataSource, UITableViewDelegate {
    //MARK: - Initializer
    let contentType: ContentType
    init(contentType: ContentType) {
        self.contentType = contentType
    }
    
    //MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let parentVC = tableView.parentViewController as! ReusableMultiCellView
        switch contentType {
        case .users:
            return parentVC.viewModel.itemCount
        case .repos:
            return 6
        case .bookmarks:
            return 7
        case .commits:
            return 8
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch contentType {
        case .users:
            let cell = tableView.dequeueReusableCell(withIdentifier: "compactUserCell", for: indexPath) as! CompactUserCell
            let userModel = (tableView.parentViewController as! ReusableMultiCellView).viewModel.dataModel?.items[indexPath.row]
            cell.cellModel = userModel
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .clear
            return cell
        case .repos:
            let cell = tableView.dequeueReusableCell(withIdentifier: "compactRepoCell", for: indexPath) as! CompactRepoCell
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .clear
            return cell
        case .bookmarks:
            let section = CellType(rawValue: indexPath.section)
            switch section {
            case .repo:
                let cell = tableView.dequeueReusableCell(withIdentifier: "compactRepoCell", for: indexPath) as! CompactRepoCell
                cell.accessoryType = .disclosureIndicator
                cell.backgroundColor = .clear
                return cell
            case .user:
                let cell = tableView.dequeueReusableCell(withIdentifier: "compactUserCell", for: indexPath) as! CompactUserCell
                cell.userLabel.text = "Ahmed Fathy"
                cell.accessoryType = .disclosureIndicator
                cell.backgroundColor = .clear
                return cell
            case .none: return UITableViewCell()
            }
        case .commits:
            let cell = tableView.dequeueReusableCell(withIdentifier: "commitCell", for: indexPath) as! CommitCell
            cell.committerName.text = "Ahmed Fathy"
            cell.commit.text = "Updating Variables"
            cell.committerImage.image = UIImage(named: "me")
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch contentType {
        case .users:
            return 70
        case .repos:
            return 103
        case .bookmarks:
            let section = CellType(rawValue: indexPath.section)
            switch section {
            case .repo: return 103
            case .user: return 70
            case .none: return 0
            }
        case .commits:
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let parentVC = tableView.parentViewController as! ReusableMultiCellView
        switch contentType {
        case .users:
            let userModel = (tableView.parentViewController as! ReusableMultiCellView).viewModel.dataModel?.items[indexPath.row]
            parentVC.goToUser(with: userModel?.userName)
        case .repos: parentVC.goToUserCommits()
        case .bookmarks:
            let section = CellType(rawValue: indexPath.section)
            switch section {
            case .repo: parentVC.goToUserCommits()
            case .user:
                let userModel = (tableView.parentViewController as! ReusableMultiCellView).viewModel.dataModel?.items[indexPath.row]
                parentVC.goToUser(with: userModel?.userName)
            case .none: break
            }
        case .commits: print("No more navigation")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch contentType {
        case .users: return 1
        case .repos: return 1
        case .commits: return 1
        case .bookmarks: return CellType.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch contentType {
        case .users: break
        case .repos: break
        case .commits: break
        case .bookmarks: return CellType(rawValue: section)?.description
        }
        return nil
    }
}
