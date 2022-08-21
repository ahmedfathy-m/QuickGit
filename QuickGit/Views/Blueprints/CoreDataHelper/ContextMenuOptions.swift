//
//  ContextMenuOptions.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 21/08/2022.
//

import UIKit

extension CoreDataHelper {
    
    fileprivate var currentViewController: UIViewController? {
        let currentScene = UIApplication.shared.connectedScenes.first as! UIWindowScene
        let vc = currentScene.keyWindow?.rootViewController
        let topVC = (vc as! UINavigationController).topViewController
        if let topVC = topVC as? UITabBarController{
            return topVC.selectedViewController
        }
        return topVC
    }
    
    func bookmarkItem(at cell: UITableViewCell) -> UIAction {
        let action = UIAction(title: "Bookmark", image: UIImage(systemName: "bookmark.fill"),state: .off) { _ in
            if let cell = cell as? CompactUserCell {
                let bookmarkedUser = BookmarkedUser(context: self.context!)
                bookmarkedUser.userName = cell.userLabel.text
                bookmarkedUser.image = cell.userImage.image?.jpegData(compressionQuality: 0.8)
                
            } else if let cell = cell as? CompactRepoCell {
                let bookmarkedRepo = BookmarkedRepository(context: self.context!)
                bookmarkedRepo.repoID = Int32(cell.repoModel!.repoID)
                bookmarkedRepo.repoName = cell.repoModel?.repoName
                bookmarkedRepo.devLang = cell.repoModel?.devLang
                bookmarkedRepo.starsCount = Int32(cell.repoModel!.starsCount)
                bookmarkedRepo.repoAbout = cell.repoModel?.repoDescription
                
            }
            
            do {
                try self.context!.save()
            } catch {
                let errorMessage = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .actionSheet)
                errorMessage.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.currentViewController?.present(errorMessage, animated: true)
            }
        }
        return action
    }
    
    func openInSafari(at indexPath: IndexPath) -> UIAction {
        let action = UIAction(title: "Open In Safari", image: UIImage(systemName: "safari"), state: .off) { _ in
            var link = "https://github.com/"
            switch indexPath.section {
            case 0: link = "https://github.com/\(self.bookmarkedRepos[indexPath.row].repoName ?? "")"
            case 1: link = "https://github.com/\(self.bookmarkedUsers[indexPath.row].userName ?? "")"
            default: break
            }
            
            if let linkURL = URL(string: link) {
                UIApplication.shared.open(linkURL)
            }
        }
        return action
    }
    
    func deleteBookmark(at indexPath: IndexPath) -> UIAction {
        let action = UIAction(title: "Delete", image: UIImage(systemName: "trash.slash.fill"), state: .off) { _ in
            switch indexPath.section {
            case 0:
                self.context?.delete(self.bookmarkedRepos[indexPath.row])
                self.bookmarkedRepos.remove(at: indexPath.row)
            case 1:
                self.context?.delete(self.bookmarkedUsers[indexPath.row])
                self.bookmarkedUsers.remove(at: indexPath.row)
            default: break
            }

            do {
                try self.context?.save()
            } catch {
                print(error.localizedDescription)
                let errorMessage = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .actionSheet)
                errorMessage.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.currentViewController?.present(errorMessage, animated: true)
                self.context?.reset()
            }
            let tableView = self.currentViewController?.view.subviews.first(where: {$0.isKind(of: UITableView.self)}) as! UITableView
            tableView.reloadData()
        }
        return action
    }
    
    func shareToSocial(cell: UITableViewCell) -> UIAction {
        let action = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up"), state: .off) { _ in
            var textToShare = String()
            var clickableLink = String()
            if let cell = cell as? CompactUserCell {
                clickableLink = "https://github.com/\(cell.cellModel?.userName ?? "")"
                textToShare = "Check out this contributor on github"
            } else if let cell = cell as? CompactRepoCell {
                clickableLink = "https://github.com/\(cell.repoModel?.repoName ?? "")"
                textToShare = "Check out this repository on github"
            }
            
            if let clickableURL = URL(string: clickableLink) {
                let objectsToShare: [Any] = [textToShare, clickableURL]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                self.currentViewController?.present(activityVC, animated: true)
            }
        }
        return action
    }
}
