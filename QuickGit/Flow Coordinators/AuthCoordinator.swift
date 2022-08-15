//
//  AuthCoordinator.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 10/08/2022.
//

import UIKit

final class AuthCoordinator: Coordinator {
    var parentCoordinator: AppCoordinator?
    
    override func start() {
        let authView = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "Login") as! LoginView
        authView.coordinator = self
        navigationController.pushViewController(authView, animated: true)
    }
    
    func didFinishAuthentication() {
        DispatchQueue.main.async {
            self.parentCoordinator?.mainCoordinator.start()
        }
    }
}
