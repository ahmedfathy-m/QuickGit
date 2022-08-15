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
    
    var params: [String:String]{
        switch self {
        case .popularUsers:
//            return ["q": "repos:%3E35+followers:%3E1000"]
            return ["q": "repos:>35+followers:>1000"]
            
        case .someUser(_):
            return [:]
        case .userRepos(_):
            return [:]
        case .browseRepos:
            return ["q": "stars:>2000",
                    "sort": "stars",
                    "per_page": "10",
                    "page": "1"]
        case .commitsInRepository(let target):
            return ["q": "repo:\(target)+is:public",
                    "per_page": "10",
                    "page": "1"]
        case .starredReposByUser(_):
            return [:]
        case .searchUsers(_):
            return [:]
        }
    }
    
    var targetURL: String {
        switch self {
        case .popularUsers: return "\(baseURL)/search/users"
        case .someUser(let user): return "\(baseURL)/users/\(user)"
        case .userRepos(let user): return "\(baseURL)/users/\(user)/repos"
        case .browseRepos: return "\(baseURL)/search/repositories"
        case .commitsInRepository: return "\(baseURL)/search/commits"
        case .starredReposByUser(let user): return "\(baseURL)/users/\(user)/starred"
        case .searchUsers(_): return "\(baseURL)/search/users"
        }
    }
    
    case popularUsers
    case browseRepos
    case searchUsers(_ query: String)
    case someUser(_ user: String)
    case userRepos(_ user: String)
    case commitsInRepository(_ repo: String)
    case starredReposByUser(_ user: String)
    
}
