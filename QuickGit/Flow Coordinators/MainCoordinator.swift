//
//  MainCoordinator.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 10/08/2022.
//

import UIKit

final class MainCoordinator: Coordinator {
    var parentCoordinator: AppCoordinator?
    private let tabController = UITabBarController()
    lazy var childControllers: [UIViewController]? = {
        let home = HomeViewController()
        let profileViewModel = ProfileViewModel(with: nil)
        let profile = ProfileViewController(viewModel: profileViewModel)
        let bookmarks = ReusableMultiCellView(contentType: .bookmarks)
        let explore = ExploreViewController()
        home.coordinator = self
        bookmarks.coordinator = self
        profile.coordinator = self
        return [home, explore, bookmarks, profile]
    }()
    override func start() {
        initTabView()
        navigationController.setViewControllers([tabController], animated: true)
    }
    
    deinit {
        print("Deallocated")
    }
    
    func initTabView() {
        navigationController.navigationBar.prefersLargeTitles = true
        tabController.tabBar.backgroundColor = .clear
        tabController.setViewControllers(childControllers, animated: true)
    }
    
    func goToUserSearch() {
        let userVC = ReusableMultiCellView(contentType: .users(.popularUsers))
        userVC.coordinator = self
        userVC.title = "Users"
        navigationController.pushViewController(userVC, animated: true)
    }
    
    func goToReposSearch() {
        let reposVC = ReusableMultiCellView(contentType: .repos(.popularRepos))
        reposVC.coordinator = self
        reposVC.title = "Repositories"
        navigationController.pushViewController(reposVC, animated: true)
    }
    
    func goToCommitsView(_ targetRepo: String) {
        let commitsVC = ReusableMultiCellView(contentType: .commits(targetRepo))
        commitsVC.coordinator = self
        commitsVC.title = "Commits"
        navigationController.pushViewController(commitsVC, animated: true)
    }
    
    func goToUser(with name: String?) {
        let viewModel = ProfileViewModel(with: name)
        let userVC = ProfileViewController(viewModel: viewModel)
        userVC.navigationItem.title = "User"
        userVC.coordinator = self
        navigationController.pushViewController(userVC, animated: true)
    }
    
    func goToSettings() {
        let settingsVC = SettingsViewController()
        settingsVC.coordinator = self
        settingsVC.title = "Settings"
        navigationController.pushViewController(settingsVC, animated: true)
    }
    
    func goToUserRepoistories(_ login: String) {
        let reposVC = ReusableMultiCellView(contentType: .repos(.someUser(login)))
        reposVC.coordinator = self
        reposVC.title = "Repositories"
        navigationController.pushViewController(reposVC, animated: true)
    }
    
    func goToStarredRepositories(_ login: String) {
        let reposVC = ReusableMultiCellView(contentType: .repos(.starredRepos(login)))
        reposVC.coordinator = self
        reposVC.title = "Repositories"
        navigationController.pushViewController(reposVC, animated: true)
    }
    
    func returnToLogin() {
        print(parentCoordinator)
        parentCoordinator?.authCoordinator.start()
    }
    
}
