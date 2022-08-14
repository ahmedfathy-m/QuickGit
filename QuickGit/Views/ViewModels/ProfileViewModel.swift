//
//  ProfileViewModel.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 14/08/2022.
//

import Foundation

class ProfileViewModel {
    weak var delegate: ProfileViewController?
    
    let userName: String?
    
    var dataModel: ProfileModel? {
        didSet {
            delegate?.didUpdateDataModel()
        }
    }
    
    func start() async throws {
        switch userName {
        case nil: break
        case .some(_): dataModel = try await GitHubHandler().handleRequest(using: .someUser(""), parameters: [:], headers: nil)
        }
    }
    
    init(with name: String?) {
        self.userName = name
    }
}
