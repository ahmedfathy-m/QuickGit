//
//  UserModel.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 14/08/2022.
//

import Foundation

struct UserSearchModel: Decodable {
    let resultsCount: Int
    let isResultsComplete: Bool
    let items: [UserModel]
    
    enum CodingKeys: String, CodingKey {
        case resultsCount = "total_count"
        case isResultsComplete = "incomplete_results"
        case items
    }
}

struct UserModel: Decodable {
    let userID: Int
    let userName: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "id"
        case userName = "login"
        case avatarURL = "avatar_url"
    }
}

struct ProfileModel: Decodable {
    let userID: Int
    let userName: String
    let avatarURL: String
    let fullName: String
    let location: String
    let bio: String
    let followers: Int
    let following: Int
    
    enum CodingKeys: String, CodingKey {
        case userID = "id"
        case userName = "login"
        case avatarURL = "avatar_url"
        case fullName = "name"
        case location, bio, followers, following
    }
}
