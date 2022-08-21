//
//  BookmarksViewModel.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 19/08/2022.
//

import UIKit
import CoreData

class BookmarksViewModel: ViewModelProtocol {
    weak var delegate: ViewModelDelegate?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var users: [BookmarkedUser] {
      return CoreDataHelper.shared.bookmarkedUsers
    }
    var repos: [BookmarkedRepository] {
      return CoreDataHelper.shared.bookmarkedRepos
    }
    
    func start() {
      //Bookmarks View Model doesn't need a start action
    }
    
    func fetchChildActions(for cell: UITableViewCell, at indexPath: IndexPath) -> [UIAction] {
        let childActions: [UIAction] = [CoreDataHelper.shared.deleteBookmark(at:indexPath),
                                        CoreDataHelper.shared.openInSafari(at: indexPath),
                                        CoreDataHelper.shared.shareToSocial(cell: cell)]
        return childActions
    }


    
    func configure(cell: UITableViewCell, at indexPath: IndexPath) {
        if let cell = cell as? CompactRepoCell {
            let repoAtCell = repos[indexPath.row]
            cell.repoModel = Repository(repoID: Int(repoAtCell.repoID), repoName: (repoAtCell.repoName!), repoDescription: repoAtCell.repoAbout, starsCount: Int(repoAtCell.starsCount), followers: Int(repoAtCell.followers), devLang: repoAtCell.devLang)
            return
        } else if let cell = cell as? CompactUserCell {
            let userAtCell = users[indexPath.row]
            cell.userLabel.text = userAtCell.userName
            if let imageData = userAtCell.image {
                cell.userImage.image = UIImage(data: imageData)
            }
        }
    }
}
