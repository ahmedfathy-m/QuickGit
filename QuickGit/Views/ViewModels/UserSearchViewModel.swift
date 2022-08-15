//
//  UserSearchViewModel.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 14/08/2022.
//

import Foundation

class UserSearchViewModel: ViewModelProtocol {
    
    init(type: UsersPageType) {
        self.pageType = type
    }
    
    var pageType: UsersPageType
    
    weak var delegate: ViewModelDelegate?
    
    var itemCount: Int {
        return dataModel?.items.count ?? 0
    }
    
    var dataModel: UserSearchModel? {
        didSet {
            delegate?.didUpdateDataModel()
        }
    }
    
    var cachedModel: UserSearchModel?
    
    func start() async throws{
        dataModel = try await NetworkHandler().loadRequest(using: .popularUsers, parameters: nil, headers: nil)
    }
    
    func search(query: String) async throws {
        if cachedModel == nil {
            cachedModel = dataModel
        }
        dataModel = try await NetworkHandler().loadRequest(using: .popularUsers, parameters: ["q": query], headers: nil)
    }
    
    func restoreDataModel() {
        if cachedModel != nil {
            dataModel = cachedModel
            cachedModel = nil
        }
    }
    
}
