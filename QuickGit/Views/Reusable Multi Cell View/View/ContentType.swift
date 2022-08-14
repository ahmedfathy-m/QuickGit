//
//  ContentType.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 13/08/2022.
//

import Foundation

enum ContentType {
    case users
    case repos
    case commits
    case bookmarks
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
