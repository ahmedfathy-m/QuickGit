//
//  RepositoryModel.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 14/08/2022.
//

import Foundation

struct RepositorySearchModel: Decodable {
    let resultsCount: Int
    let isResultsComplete: Bool
    var items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case resultsCount = "total_count"
        case isResultsComplete = "incomplete_results"
        case items
    }
}

struct Repository: Decodable {
    let repoID: Int
    let repoName: String
    let repoDescription: String?
    let starsCount: Int
    let devLang: String?
    
    enum CodingKeys: String, CodingKey {
        case repoID = "id"
        case repoName = "full_name"
        case repoDescription = "description"
        case starsCount = "stargazers_count"
        case devLang = "language"
    }
}
