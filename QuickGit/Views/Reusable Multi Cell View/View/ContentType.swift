//
//  ContentType.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 13/08/2022.
//

import Foundation

enum ContentType {
    case users(_ pageType: UsersPageType)
    case repos(_ pageType: RepositoryPageType)
    case commits(_ targetRepo: String)
    case bookmarks
    
    var targetRepo: String {
        switch self {
        case .commits(let target): return target
        default: return ""
        }
    }
}

enum UsersPageType {
    case popularUsers
    case searchQuery(_ query: String)
}

enum RepositoryPageType {
    case someUser(_ userName: String)
    case searchQuery(_ query: String)
    case popularRepos
    case starredRepos(_ userName: String)
}

enum CellType: Int, CaseIterable, CustomStringConvertible {
    case repo
    case user
    
    var description: String {
        switch self {
        case .repo: return "Repositories"
        case .user: return "Users"
        }
    }
}
