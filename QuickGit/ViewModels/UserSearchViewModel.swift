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
        return dataModel?.count ?? 0
    }
    
    var dataModel: [UserModel]? {
        didSet {
            delegate?.didUpdateDataModel()
        }
    }
    
    var cachedModel: [UserModel]?
    
    func start() async throws{
        let model: UserSearchModel = try await NetworkHandler().loadRequest(using: .popularUsers("1"), parameters: nil, headers: nil)
        dataModel = model.items
    }
    
    var currentPage = 1
    
    func getNextPage() async throws{
        currentPage += 1
        let model : UserSearchModel = try await NetworkHandler().loadRequest(using: .popularUsers(String(currentPage)), parameters: nil, headers: nil)
        dataModel?.append(contentsOf: model.items)
    }
    
    func search(query: String) async throws {
        if cachedModel == nil {
            cachedModel = dataModel
        }
        let model: UserSearchModel = try await NetworkHandler().loadRequest(using: .popularUsers(String()), parameters: ["q": query], headers: nil)
        dataModel = model.items
    }
    
    func restoreDataModel() {
        if cachedModel != nil {
            dataModel = cachedModel
            cachedModel = nil
        }
    }
    
}
