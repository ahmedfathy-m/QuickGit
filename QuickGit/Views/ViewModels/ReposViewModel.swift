//
//  ReposViewModel.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 14/08/2022.
//

import Foundation



class ReposViewModel: ViewModelProtocol {
    
    init(type: RepositoryPageType) {
        self.queryType = type
    }
    
    var queryType: RepositoryPageType
    
    weak var delegate: ViewModelDelegate?
    
    var itemCount: Int {
        return dataModel?.count ?? 0
    }
    
    var dataModel: [Repository]? {
        didSet {
            delegate?.didUpdateDataModel()
        }
    }
    
    func start() async throws{
        var model: RepositorySearchModel? = nil
        switch queryType {
        case .someUser(let userName):
            let array: [Repository] = try await NetworkHandler().loadRequest(using: .userRepos(userName), parameters: nil, headers: nil)
            dataModel = array
        case .searchQuery: break
        case .popularRepos:
            model = try await NetworkHandler().loadRequest(using: .browseRepos, parameters: nil, headers: nil)
            dataModel = model?.items
        case .starredRepos(let userName):
            let array: [Repository] = try await NetworkHandler().loadRequest(using: .starredReposByUser(userName), parameters: nil, headers: nil)
            dataModel = array
        }
    }
}
