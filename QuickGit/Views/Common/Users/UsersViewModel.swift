//
//  UsersViewModel.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 21/08/2022.
//

import UIKit

class UsersViewModel: ViewModelProtocol {
    weak var delegate: ViewModelDelegate?
    
    fileprivate var currentPage = 1
    fileprivate var currentQuery = "repos:>35+followers:>1000"
    fileprivate var chunkSize = 30
    
    fileprivate var reachedListEnd = false
    fileprivate var cacheReachListEnd = false
    
    var parameters: [String: String] {
        let params = ["q": currentQuery,
                      "per_page": String(chunkSize),
                      "page": String(currentPage)]
        return params
    }
    
    var itemCount: Int {
        return dataModel.count
    }
    
    var dataModel: [UserModel] = [] {
        didSet {
            delegate?.didUpdateDataModel()
        }
    }
    var cachedModel: [UserModel] = []
    
    func start() async throws {
        let model: UserSearchModel = try await NetworkHandler.shared.loadRequest(using: .searchUsers, parameters: parameters, headers: nil)
        reachedListEnd = false
        if currentPage == 1 {
            dataModel = model.items
        } else {
            dataModel.append(contentsOf: model.items)
        }
    }
    
    func fetchNextEntries() async throws {
        guard reachedListEnd == false else { return }
        currentPage += 1
        let modelBefore = dataModel.count
        try await start()
        let modelAfter = dataModel.count
        
        if modelBefore == modelAfter {
            reachedListEnd = true
        }
    }
    
    func search(for query: String) async throws {
        if !(query.isEmpty) {
            currentQuery = query
            if cachedModel.isEmpty {
                cachedModel = dataModel
                cacheReachListEnd = reachedListEnd
            }
            try await start()
        } else {
            restoreDataModel()
        }
    }
    
    fileprivate func restoreDataModel() {
        if !(cachedModel.isEmpty) {
            dataModel = cachedModel
            reachedListEnd = cacheReachListEnd
            cachedModel = []
        }
        if currentQuery != "repos:>35+followers:>1000" {
            currentQuery = "repos:>35+followers:>1000"
        }
    }
    
    func configure(_ cell:UITableViewCell, at indexPath: IndexPath){
        let userModel = dataModel[indexPath.row]
        let cell = cell as! CompactUserCell
        cell.cellModel = userModel
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .clear
    }
    
    func fetchChildActions(for cell: UITableViewCell, at indexPath: IndexPath) -> [UIAction] {
        let childActions: [UIAction] = [CoreDataHelper.shared.bookmarkItem(at: cell),
                                        CoreDataHelper.shared.openInSafari(at: indexPath),
                                        CoreDataHelper.shared.shareToSocial(cell: cell)]
        return childActions
    }
}
