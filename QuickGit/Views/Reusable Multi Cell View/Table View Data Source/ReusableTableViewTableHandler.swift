//
//  ReusableTableViewTableHandler.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 12/08/2022.
//

import UIKit
import CoreData
import Kingfisher

class ReusableTableViewTableHandler: NSObject, UITableViewDataSource, UITableViewDelegate {
    //MARK: - Initializer
    var rootTableView = UITableView()
    lazy var rootVC = rootTableView.parentViewController as! ReusableMultiCellView
    
    let bookmarkContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    let contentType: ContentType
    func loadBookmarkedData() {
        bookmarkedUsers = []
        let usersRequest: NSFetchRequest<BookmarkedUser> = BookmarkedUser.fetchRequest()
        let reposRequest: NSFetchRequest<BookmarkedRepository> = BookmarkedRepository.fetchRequest()
        do {
            bookmarkedUsers = try bookmarkContext!.fetch(usersRequest)
            bookmarkedRepos = try bookmarkContext!.fetch(reposRequest)
        } catch {
            print(error)
        }
    }
    
    
    init(contentType: ContentType) {
        self.contentType = contentType
        super.init()
        loadBookmarkedData()
    }
    
    var bookmarkedUsers = [BookmarkedUser]()
    var bookmarkedRepos = [BookmarkedRepository]()
    
    //MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rootTableView = tableView
        let parentVC = tableView.parentViewController as! ReusableMultiCellView
        switch contentType {
        case .users:
            return parentVC.viewModel?.itemCount ?? 0
        case .repos:
            return parentVC.viewModel?.itemCount ?? 0
        case .bookmarks:
            let section = CellType(rawValue: section)
            switch section {
            case .repo: return bookmarkedRepos.count
            case .user: return bookmarkedUsers.count
            case .none: return 0
            }
        case .commits:
            return parentVC.viewModel?.itemCount ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let parentVC = (tableView.parentViewController as! ReusableMultiCellView)
        switch contentType {
        case .users:
            let cell = tableView.dequeueReusableCell(withIdentifier: "compactUserCell", for: indexPath) as! CompactUserCell
            let userModel = (parentVC.viewModel as! UserSearchViewModel).dataModel?[indexPath.row]
            cell.cellModel = userModel
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .clear
            return cell
        case .repos:
            let cell = tableView.dequeueReusableCell(withIdentifier: "compactRepoCell", for: indexPath) as! CompactRepoCell
            let repoModel = (parentVC.viewModel as! ReposViewModel).dataModel?[indexPath.row]
            cell.repoModel = repoModel
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .clear
            return cell
        case .bookmarks:
            let section = CellType(rawValue: indexPath.section)
            switch section {
            case .repo:
                let cell = tableView.dequeueReusableCell(withIdentifier: "compactRepoCell", for: indexPath) as! CompactRepoCell
                let bookmarkedRepo = bookmarkedRepos[indexPath.row]
                let cellModel = Repository(repoID: Int(bookmarkedRepo.repoID), repoName: bookmarkedRepo.repoName!, repoDescription: bookmarkedRepo.repoAbout, starsCount: Int(bookmarkedRepo.starsCount),followers: Int(bookmarkedRepo.followers) ,devLang: bookmarkedRepo.devLang)
                cell.repoModel = cellModel
                cell.accessoryType = .disclosureIndicator
                cell.backgroundColor = .clear
                return cell
            case .user:
                let cell = tableView.dequeueReusableCell(withIdentifier: "compactUserCell", for: indexPath) as! CompactUserCell
                cell.userLabel.text = bookmarkedUsers[indexPath.row].userName
                if let imageData = bookmarkedUsers[indexPath.row].image {
                    cell.userImage.image = UIImage(data: imageData)
                }
                cell.accessoryType = .disclosureIndicator
                cell.backgroundColor = .clear
                return cell
            case .none: return UITableViewCell()
            }
        case .commits:
            let cell = tableView.dequeueReusableCell(withIdentifier: "commitCell", for: indexPath) as! CommitCell
            let commitModel = (parentVC.viewModel as! CommitsViewModel).dataModel?.items[indexPath.row]
            cell.commitEntry = commitModel
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
            let userModel = (parentVC.viewModel as! UserSearchViewModel).dataModel?[indexPath.row]
            parentVC.goToUser(with: userModel?.userName)
        case .repos:
            if let repoModel = (parentVC.viewModel as! ReposViewModel).dataModel?[indexPath.row] {
                parentVC.goToUserCommits(repoModel.repoName)
            }
        case .bookmarks:
            let section = CellType(rawValue: indexPath.section)
            switch section {
            case .repo: break
            case .user:
                if let userModel = (parentVC.viewModel as? UserSearchViewModel)?.dataModel?[indexPath.row] {
                    parentVC.goToUser(with: userModel.userName)
                }
            case .none: break
            }
        case .commits:
            if let commitModel = (parentVC.viewModel as! CommitsViewModel).dataModel?.items[indexPath.row] {
                UIApplication.shared.open(URL(string: commitModel.commitURL)!)
            }
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
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {

        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            let bookmark = UIAction(title: "Bookmark", image: UIImage(systemName: "bookmark"), identifier: nil, discoverabilityTitle: nil, state: .off) { (action) in

                switch self.contentType {
                case .users: self.bookmarkUser(at: indexPath, in: tableView)
                case .repos: self.bookmarkRepo(at: indexPath, in: tableView)
                default: break
                }
            }
            
            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up"), identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in
                self.shareToSocial(at: indexPath, in: tableView)
            }
            
            let safari = UIAction(title: "Open in Safari", image: UIImage(systemName: "safari"), identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in
                var clickableLink = String()
                switch self.contentType {
                case .users:
                    let cellModel = (tableView.cellForRow(at: indexPath) as! CompactUserCell).cellModel
                    clickableLink = "https://github.com/\(cellModel?.userName ?? "")"
                case .repos:
                    let cellModel = (tableView.cellForRow(at: indexPath) as! CompactRepoCell).repoModel
                    clickableLink = "https://github.com/\(cellModel?.repoName ?? "")"
                case .commits: break
                case .bookmarks:
                    let section = CellType(rawValue: indexPath.section)
                    switch section {
                    case .repo:
                        let cellModel = self.bookmarkedRepos[indexPath.row]
                        clickableLink = "https://github.com/\(cellModel.repoName ?? "")"
                    case .user:
                        let cellModel = self.bookmarkedUsers[indexPath.row]
                        clickableLink = "https://github.com/\(cellModel.userName ?? "")"
                    default: break
                    }
                }
                if let clickableURL = URL(string: clickableLink) {
                    UIApplication.shared.open(clickableURL)
                }
            }
            
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash.slash"), identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in
                switch self.contentType {
                case .bookmarks:
                    let section = CellType(rawValue: indexPath.section)
                    switch section {
                    case .repo: self.deleteRepo(at: indexPath, in: tableView)
                    case .user: self.deleteUser(at: indexPath, in: tableView)
                    case .none: break
                    }
                    
                default: break
                }
                
            }
            
            switch self.contentType {
            case .commits: return UIMenu(title: "Options", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [share,safari])
            case .bookmarks: return UIMenu(title: "Options", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [delete,share,safari])
            default: break
            }
            return UIMenu(title: "Options", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [bookmark,share,safari])
        }
        return context
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > tableView.numberOfRows(inSection: 0) - 2 {
            rootTableView = tableView
            switch contentType {
            case .users:
                Task {
                    try await (rootVC.viewModel as! UserSearchViewModel).getNextPage()
                }
            case .repos:
                Task {
                    try await (rootVC.viewModel as! ReposViewModel).getNextPage()
                }
            case .commits: break
            case .bookmarks: break
            }
        }
    }
    
    func bookmarkRepo(at indexPath:IndexPath, in tableView: UITableView) {
        let cell = tableView.cellForRow(at: indexPath) as! CompactRepoCell
        let cellModel = cell.repoModel
        let newBookmarkedRepo = BookmarkedRepository(context: bookmarkContext!)
        newBookmarkedRepo.repoID = Int32(cellModel!.repoID)
        newBookmarkedRepo.repoName = cellModel?.repoName
        newBookmarkedRepo.devLang = cellModel?.devLang
        newBookmarkedRepo.starsCount = Int32(cellModel!.starsCount)
        newBookmarkedRepo.repoAbout = cellModel?.repoDescription
        do {
            try self.bookmarkContext?.save()
        } catch {
            print(error.localizedDescription)
            bookmarkContext?.reset()
        }
    }
    
    func bookmarkUser(at indexPath: IndexPath, in tableView: UITableView) {
        let parentVC = tableView.parentViewController as! ReusableMultiCellView
        let cellModel = (parentVC.viewModel as! UserSearchViewModel).dataModel?[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! CompactUserCell
        let newBookmarkedUser = BookmarkedUser(context: bookmarkContext!)
        newBookmarkedUser.userName = cellModel?.userName
        newBookmarkedUser.image = cell.userImage.image?.jpegData(compressionQuality: 0.8)
        do {
            try self.bookmarkContext?.save()
        } catch {
            print(error.localizedDescription)
            bookmarkContext?.reset()
        }
    }
    
    func deleteUser(at indexPath:IndexPath, in tableView: UITableView){
        bookmarkContext?.delete(bookmarkedUsers[indexPath.row])
        bookmarkedUsers.remove(at: indexPath.row)
        do {
            try self.bookmarkContext?.save()
        } catch {
            print(error.localizedDescription)
            bookmarkContext?.reset()
        }
        tableView.reloadData()
    }
    
    func deleteRepo(at indexPath:IndexPath, in tableView: UITableView){
        bookmarkContext?.delete(bookmarkedRepos[indexPath.row])
        bookmarkedRepos.remove(at: indexPath.row)
        do {
            try self.bookmarkContext?.save()
        } catch {
            print(error.localizedDescription)
            bookmarkContext?.reset()
        }
        tableView.reloadData()
    }
    
    func shareToSocial(at indexPath:IndexPath, in tableView: UITableView) {
        let parentVC = tableView.parentViewController as! ReusableMultiCellView
        
        var textToShare = String()
        var clickableLink = String()
        
        switch contentType {
        case .users:
            let cellModel = (tableView.cellForRow(at: indexPath) as! CompactUserCell).cellModel
            clickableLink = "https://github.com/\(cellModel?.userName ?? "")"
            textToShare = "Check out this contributor on github"
        case .repos:
            let cellModel = (tableView.cellForRow(at: indexPath) as! CompactRepoCell).repoModel
            clickableLink = "https://github.com/\(cellModel?.repoName ?? "")"
            textToShare = "Check out this repository on github"
        case .commits: break
        case .bookmarks:
            let section = CellType(rawValue: indexPath.section)
            switch section {
            case .repo:
                let cellModel = bookmarkedRepos[indexPath.row]
                clickableLink = "https://github.com/\(cellModel.repoName ?? "")"
                textToShare = "Check out this repository on github"
            case .user:
                let cellModel = bookmarkedUsers[indexPath.row]
                clickableLink = "https://github.com/\(cellModel.userName ?? "")"
                textToShare = "Check out this contributor on github"

            case .none: textToShare = "Check this out"
            }
        }

        
        if let clickableURL = URL(string: clickableLink) {
            let objectsToShare: [Any] = [textToShare, clickableURL]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            parentVC.present(activityVC, animated: true, completion: nil)
        }
    }
}
