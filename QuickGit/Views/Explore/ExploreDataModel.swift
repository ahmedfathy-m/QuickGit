//
//  ExploreDataModel.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 17/08/2022.
//

import Foundation

enum ExploreSection: Int, CaseIterable, CustomStringConvertible {
    case topContributors
    case topWatchedRepos
    case allThingsSwift
    
    var description: String {
        switch self {
        case .topContributors: return "Top Contributors"
        case .topWatchedRepos: return "Top Repositories this week"
        case .allThingsSwift: return "All Things Swift"
        }
    }
}
