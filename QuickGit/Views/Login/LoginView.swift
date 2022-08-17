//
//  LoginView.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 15/08/2022.
//

import UIKit

class LoginView: UIViewController {
    weak var coordinator: AuthCoordinator?
    
    let module = AuthenticationModule.shared

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Again")
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        module.configure(client: APIKeys.clientID, secret: APIKeys.clientSecret)
        module.onAuthenticationCompletion = {
            self.coordinator?.didFinishAuthentication()
            AppCoordinator.userMode = .authenticated
        }
        module.askForUserPermission(scope: .user)
    }
    
    @IBAction func guestModeSelected(_ sender: UIButton) {
        AppCoordinator.userMode = .guest
        self.coordinator?.didFinishAuthentication()
    }
}
