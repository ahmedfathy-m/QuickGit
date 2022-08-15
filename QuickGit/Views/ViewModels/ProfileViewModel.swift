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
        case .some(_): dataModel = try await NetworkHandler().loadRequest(using: .someUser(userName ?? "ahmedfathy-m"), parameters: nil, headers: nil)
        }
    }
    
    init(with name: String?) {
        self.userName = name
    }
}
