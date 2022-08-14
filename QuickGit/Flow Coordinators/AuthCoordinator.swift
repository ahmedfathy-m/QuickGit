//
//  AuthCoordinator.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 10/08/2022.
//

import UIKit

final class AuthCoordinator: Coordinator {
    var parentCoordinator: AppCoordinator?
    let authView = UIViewController()
    override func start() {
        navigationController.pushViewController(authView, animated: true)
    }
}
