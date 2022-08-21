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
    
    func load() throws {
        // Start at app load
        let usersRequest: NSFetchRequest<BookmarkedUser> = BookmarkedUser.fetchRequest()
        let reposRequest: NSFetchRequest<BookmarkedRepository> = BookmarkedRepository.fetchRequest()
        
        bookmarkedUsers = try context!.fetch(usersRequest)
        bookmarkedRepos = try context!.fetch(reposRequest)
    }
}
