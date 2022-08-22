//
//  RecentlyVisitedViewModel.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 22/08/2022.
//

import UIKit

class RecentlyVisitedViewModel {
    var recentlyVisited: [RecentSearchUser] {
        return CoreDataHelper.shared.recentSearchedUsers.reversed()
    }
    
    var itemCount: Int {
        return recentlyVisited.count
    }
    
    func configure(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        let cell = cell as! LastSearchCard
        cell.userLabel.text = recentlyVisited[indexPath.row].userName
        if let data = recentlyVisited[indexPath.row].image {
            let image = UIImage(data: data)
            cell.userImage.image = image
        }
    }
}
