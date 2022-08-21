//
//  ExploreCellViewModel.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 19/08/2022.
//

import Foundation

class ExploreCellViewModel {
    var listModel: UserSearchModel?
    var dataModel: [ProfileModel]? {
        didSet {
            if dataModel?.count == 10 {
                delegate?.didLoadDataModel()
            }
        }
    }
    
    var repos: [Repository]? {
        didSet {
            if repos?.count == 10 {
                delegate?.didLoadDataModel()
            }
        }
    }
    
    var reposCount: Int {
        if repos?.count == 10 {
            return 10
        }
        return 0
    }
    
    var swiftRepos: [Repository]? {
        didSet {
            if swiftRepos?.count == 10 {
                delegate?.didLoadDataModel()
            }
        }
    }
    
    var swiftReposCount: Int {
        if swiftRepos?.count == 10 {
            return 10
        }
        return 0
    }
    
    var topUsersCount: Int {
        if dataModel?.count == 10 {
            return 10
        }
        return 0
    }
    
    weak var delegate: ExploreTableCell?
    
    fileprivate func loadTopContributors() async throws {
        listModel = nil
        dataModel = nil
        let params = ["q":"repos:>30",
                      "per_page":"10",
                      "page":"1",
                      "sort":"repositories"]
        listModel = try await NetworkHandler.shared.loadRequest(using: .searchUsers, parameters: params, headers: nil)
        if let items = listModel?.items {
            dataModel = [ProfileModel]()
            for userResult in items {
                let profileModel: ProfileModel = try await NetworkHandler.shared.loadRequest(using: .someUser(userResult.userName), parameters: nil, headers: nil)
                dataModel?.append(profileModel)
            }
        }
    }
    
    fileprivate func loadTopRepos() async throws {
        let weekAgoDate = Date.now.addingTimeInterval(-604800)
        let params = ["q":"created:>\(weekAgoDate.formatted(.iso8601))",
                      "per_page":"10",
                      "page":"1",
                      "sort":"followers"]
        let model: RepositorySearchModel = try await NetworkHandler.shared.loadRequest(using: .browseRepos, parameters: params, headers: nil)
        repos = model.items
    }
    
    fileprivate func loadSwiftRepos() async throws {
        let weekAgoDate = Date.now.addingTimeInterval(-604800)
        let params = ["q":"language:swift, created:>\(weekAgoDate.formatted(.iso8601))",
                      "per_page":"10",
                      "page":"1",
                      "sort":"followers"]
        let model: RepositorySearchModel = try await NetworkHandler.shared.loadRequest(using: .browseRepos, parameters: params, headers: nil)
        swiftRepos = model.items
    }
    
    func start() async throws{
        try await loadTopContributors()
        try await loadTopRepos()
        try await loadSwiftRepos()
    }
    
}
