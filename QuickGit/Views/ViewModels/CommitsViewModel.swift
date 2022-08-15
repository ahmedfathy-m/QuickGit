//
//  CommitsViewModel.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 15/08/2022.
//

import Foundation

class CommitsViewModel: ViewModelProtocol {
    //MARK: - View Model Init
    let targetRepo: String
    init(repo: String) {
        self.targetRepo = repo
    }
    
    //MARK: - View Model Delegate
    weak var delegate: ViewModelDelegate?
    
    var itemCount: Int {
        return dataModel?.items.count ?? 0
    }
    
    var dataModel: CommitSearchModel? {
        didSet {
            delegate?.didUpdateDataModel()
        }
    }
    
    func start() async throws {
        dataModel = try await NetworkHandler().loadRequest(using: .commitsInRepository(targetRepo), parameters: nil, headers: nil)
    }
    
    
}
