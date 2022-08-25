//
//  CommitViewModel.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 21/08/2022.
//

import UIKit

class CommitViewModel: ViewModelProtocol {
    weak var delegate: ViewModelDelegate?
    
    fileprivate var currentPage = 1
    fileprivate var repoName: String
    fileprivate var currentQuery: String { return "repo:\(repoName)+is:public" }
    fileprivate var chunkSize = 15
    
    fileprivate var reachedListEnd = false
    fileprivate var cacheReachListEnd = false
    
    init(repoName: String) {
        self.repoName = repoName
        print(currentQuery)
    }
    
    var parameters: [String: String] {
        let params = ["q": currentQuery,
                      "per_page": String(chunkSize),
                      "page": String(currentPage)]
        return params
    }
    
    var itemCount: Int {
        return dataModel.count
    }
    
    var dataModel: [CommitEntry] = [] {
        didSet {
            delegate?.didUpdateDataModel()
        }
    }
    var cachedModel: [CommitEntry] = []
    
    func start() async throws {
        let model: CommitSearchModel = try await NetworkHandler.shared.loadRequest(using: .commits, parameters: parameters, headers: nil)
        reachedListEnd = false
        if model.items.isEmpty {
            
        }
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
            currentPage -= 1
        }
    }
    
    func configure(_ cell:UITableViewCell, at indexPath: IndexPath){
        let commit = dataModel[indexPath.row]
        let cell = cell as! CommitCell
        cell.commitEntry = commit
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .clear
    }
    
    func fetchChildActions(for cell: UITableViewCell, at indexPath: IndexPath) -> [UIAction] {
        let childActions: [UIAction] = [CoreDataHelper.shared.openInSafari(at: indexPath),
                                        CoreDataHelper.shared.shareToSocial(cell: cell)]
        return childActions
    }
}
