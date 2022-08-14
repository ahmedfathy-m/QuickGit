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
    
    private var params: [String:String]{
        switch self {
        case .popularUsers:
            return ["q": "repos:%3E35+followers:%3E1000"]
        case .someUser(_):
            return [:]
        }
    }
    
    var targetURL: String {
        switch self {
        case .popularUsers: return "\(baseURL)/search/users"
        case .someUser(let user): return "\(baseURL)/users/\(user)"
        }
    }
    
    case popularUsers
    case someUser(_ user: String)
}
