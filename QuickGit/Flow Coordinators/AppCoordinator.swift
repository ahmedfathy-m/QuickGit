//
//  AppCoordinator.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 10/08/2022.
//

import UIKit

final class AppCoordinator: Coordinator {
    lazy var mainCoordinator: MainCoordinator = {
        let main = MainCoordinator(with: navigationController)
        main.parentCoordinator = self
        return main
    }()
    lazy var authCoordinator = AuthCoordinator(with: navigationController)
    private var hasCredentials: Bool {
        return false
    }
    
    static var userMode: UserMode = .guest {
        didSet {
            print(userMode)
        }
    }
    
    override func start() {
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        if hasCredentials {
            mainCoordinator.parentCoordinator = self
            mainCoordinator.start()
        } else {
            authCoordinator.parentCoordinator = self
            authCoordinator.start()
        }
    }
    
    deinit {
        print("Deallocated")
    }
}


enum UserMode: String {
    case authenticated = "Authenticated User Mode"
    case guest = "Guest Mode"
}
