//
//  UserSearchViewModel.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 14/08/2022.
//

import Foundation

class UserSearchViewModel {
    weak var delegate: ReusableMultiCellView?
    
    var itemCount: Int {
        return dataModel?.items.count ?? 0
    }
    
    var dataModel: UserSearchModel? {
        didSet {
            delegate?.didUpdateDataModel()
        }
    }
    
    func initializeViewModel() async throws{
        dataModel = try await GitHubHandler().handleRequest(using: .popularUsers, parameters: ["q": "repos:%3E35+followers:%3E1000"], headers: nil)
    }
    
}
