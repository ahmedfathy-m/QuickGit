//
//  RecentQueriesViewModel.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 22/08/2022.
//

import UIKit

class RecentQueriesViewModel {
    var recentQueries: [RecentSearchQuery] {
        return CoreDataHelper.shared.recentQueries.reversed()
    }
    
    var itemCount: Int {
        return recentQueries.count
    }
    
    func configure(_ cell: UITableViewCell, at indexPath: IndexPath) {
        (cell as! RecentSearchCell).recentQueryLabel.text = recentQueries[indexPath.row].query
    }
}
