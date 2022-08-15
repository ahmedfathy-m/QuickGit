//
//  CommitModel.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 15/08/2022.
//

import Foundation

struct CommitSearchModel: Decodable {
    let resultsCount: Int
    let isResultsComplete: Bool
    let items: [CommitEntry]
    
    enum CodingKeys: String, CodingKey {
        case resultsCount = "total_count"
        case isResultsComplete = "incomplete_results"
        case items
    }
}

struct CommitEntry: Decodable {
    let commitURL: String
    let commit: Commit
    let committer: Committer?
    
    enum CodingKeys: String, CodingKey {
        case commitURL = "url"
        case commit
        case committer
    }
}

struct Commit: Decodable {
    let commitMessage: String
    
    enum CodingKeys: String, CodingKey {
        case commitMessage = "message"
    }
}

struct Committer: Decodable {
    let committer: String
    let committerAvatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case committer = "login"
        case committerAvatarURL = "avatar_url"
    }
}
