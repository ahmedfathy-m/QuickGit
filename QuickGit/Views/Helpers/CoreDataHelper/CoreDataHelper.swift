//
//  CoreDataHelper.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 21/08/2022.
//

import UIKit
import CoreData

class CoreDataHelper {
    static let shared = CoreDataHelper()
    private init() {}
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    var bookmarkedUsers = [BookmarkedUser]()
    var bookmarkedRepos = [BookmarkedRepository]()
    var recentSearchedUsers = [RecentSearchUser]()
    var recentQueries = [RecentSearchQuery]()
    
    func load() throws {
        // Start at app load
        let usersRequest: NSFetchRequest<BookmarkedUser> = BookmarkedUser.fetchRequest()
        let reposRequest: NSFetchRequest<BookmarkedRepository> = BookmarkedRepository.fetchRequest()
        let recentUsersRequest: NSFetchRequest<RecentSearchUser> = RecentSearchUser.fetchRequest()
        let recentQueriesRequest: NSFetchRequest<RecentSearchQuery> = RecentSearchQuery.fetchRequest()
        
        bookmarkedUsers = try context!.fetch(usersRequest)
        bookmarkedRepos = try context!.fetch(reposRequest)
        recentSearchedUsers = try context!.fetch(recentUsersRequest)
        recentQueries = try context!.fetch(recentQueriesRequest)
    }
    
    func clearBookmarks() throws {
        bookmarkedRepos.forEach { repo in
            context?.delete(repo)
        }
        bookmarkedUsers.forEach { user in
            context?.delete(user)
        }
        bookmarkedRepos = []
        bookmarkedUsers = []
        try context?.save()
    }
    
    func clearHistory() throws {
        recentSearchedUsers.forEach { item in
            context?.delete(item)
        }
        recentQueries.forEach { item in
            context?.delete(item)
        }
        recentSearchedUsers = []
        recentQueries = []
        try context?.save()
    }
    
}
