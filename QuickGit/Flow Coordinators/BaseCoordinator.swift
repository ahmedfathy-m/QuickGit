//
//  BaseCoordinator.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 10/08/2022.
//

import UIKit

class Coordinator {
    let navigationController: UINavigationController
//    weak var parentCoordinator: Coordinator?
    
    func start() {
        
    }
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
