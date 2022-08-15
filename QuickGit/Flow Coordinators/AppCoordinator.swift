//
//  AppCoordinator.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 10/08/2022.
//

import UIKit

final class AppCoordinator: Coordinator {
    lazy var mainCoordinator = MainCoordinator(with: navigationController)
    lazy var authCoordinator = AuthCoordinator(with: navigationController)
    private var hasCredentials: Bool {
        return false
    }
    
    static var userMode: String {
        return "Guest Mode"
    }
    override func start() {
        if hasCredentials {
            mainCoordinator.parentCoordinator = self
            mainCoordinator.start()
        } else {
            authCoordinator.parentCoordinator = self
            authCoordinator.start()
        }
    }
}
