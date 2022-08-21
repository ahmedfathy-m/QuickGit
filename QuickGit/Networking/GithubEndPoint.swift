//
//  GithubEndPoint.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 12/08/2022.
//

import Foundation

enum GitHubEndPoint {
    private var baseURL: String {
        return "https://api.github.com"
    }
    
    var defaultParameters: [String:String]{
        switch self {
        case .popularUsers(let page):
//            return ["q": "repos:%3E35+followers:%3E1000"]
            return ["q": "repos:>35+followers:>1000",
                    "per_page":"30",
                    "page":page]
            
        case .someUser(_):
            return [:]
        case .userRepos(_):
            return [:]
        case .browseRepos:
            return ["q": "stars:>2000",
                    "sort": "stars",
                    "per_page": "10"]
        case .commits:
            return [:]
        case .starredBy(_):
            return [:]
        case .searchUsers:
            return [:]
        case .authenticatedUser:
            return [:]
        }
    }
    
    var targetURL: String {
        switch self {
        case .popularUsers: return "\(baseURL)/search/users"
        case .someUser(let user): return "\(baseURL)/users/\(user)"
        case .userRepos(let user): return "\(baseURL)/users/\(user)/repos"
        case .browseRepos: return "\(baseURL)/search/repositories"
        case .commits: return "\(baseURL)/search/commits"
        case .starredBy(let user): return "\(baseURL)/users/\(user)/starred"
        case .searchUsers: return "\(baseURL)/search/users"
        case .authenticatedUser: return "\(baseURL)/user"
        }
    }
    
    case popularUsers(_ page: String)
    case browseRepos
    case searchUsers
    case someUser(_ user: String)
    case userRepos(_ user: String)
    case commits
    case starredBy(_ user: String)
    case authenticatedUser
    
}
