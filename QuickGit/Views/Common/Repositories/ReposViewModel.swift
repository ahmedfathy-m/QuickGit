//
//  ReposViewModel.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 21/08/2022.
//

import UIKit

class RepositoriesViewModel: ViewModelProtocol {
    weak var delegate: ViewModelDelegate?
    
    fileprivate var currentPage = 1
    var currentQuery = "followers:>1000"
    fileprivate var chunkSize = 30
    
    fileprivate var reachedListEnd = false
    fileprivate var cacheReachListEnd = false
    
    fileprivate var starringUser = ""
    var isStarredRepos = false
    
    fileprivate var parameters: [String: String] {
        if isStarredRepos {
            return ["per_page": String(chunkSize),
                    "page": String(currentPage)]
        } else {
            return ["q": currentQuery,
                    "per_page": String(chunkSize),
                    "page": String(currentPage)]
        }
    }
    
    init(by user: String) {
        self.currentQuery = "user:\(user)"
    }
    
    init() {}
    
    init(starredBy user: String) {
        self.isStarredRepos = true
        self.starringUser = user
    }
    
    var itemCount: Int {
        return dataModel.count
    }
    
    var dataModel: [Repository] = [] {
        didSet {
            delegate?.didUpdateDataModel()
        }
    }
    var cachedModel: [Repository] = []
    
    func start() async throws {
        if isStarredRepos {
            let model: [Repository] = try await NetworkHandler.shared.loadRequest(using: .starredBy(starringUser), parameters: parameters, headers: nil)
            reachedListEnd = false
            if currentPage == 1 {
                dataModel = model
            } else {
                dataModel.append(contentsOf: model)
            }
        } else {
            let model: RepositorySearchModel = try await NetworkHandler.shared.loadRequest(using: .browseRepos, parameters: parameters, headers: nil)
            reachedListEnd = false
            if currentPage == 1 {
                dataModel = model.items
            } else {
                dataModel.append(contentsOf: model.items)
            }
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
            currentPage -= 1
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
        if currentQuery != "followers:>1000" {
            currentQuery = "followers:>1000"
        }
    }
    
    func configure(_ cell:UITableViewCell, at indexPath: IndexPath){
        let repoModel = dataModel[indexPath.row]
        let cell = cell as! CompactRepoCell
        cell.repoModel = repoModel
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

