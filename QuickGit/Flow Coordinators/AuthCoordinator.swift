//
//  AuthCoordinator.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 10/08/2022.
//

import UIKit

final class AuthCoordinator: Coordinator {
    var parentCoordinator: AppCoordinator?
    
    lazy var authView: LoginView? = {
        let view = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "Login") as! LoginView
        view.coordinator = self
        return view
    }()
    
    override func start() {
        if let authView = authView {
            navigationController.setViewControllers([authView], animated: true)
        }
    }
    
    func didFinishAuthentication() {
        DispatchQueue.main.async {
            self.parentCoordinator?.mainCoordinator.start()
        }
    }
    
}
