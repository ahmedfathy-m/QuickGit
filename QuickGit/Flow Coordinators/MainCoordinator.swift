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
    override func start() {
        initTabView()
        navigationController.setViewControllers([tabController], animated: true)
//        navigationController.pushViewController(tabController, animated: true)
    }
    
    deinit {
        print("Deallocated")
    }
    
    func initTabView() {
        let home = HomeViewController()
        let profileViewModel = ProfileViewModel(with: nil)
        let profile = ProfileViewController(viewModel: profileViewModel)
        let bookmarks = ReusableMultiCellView(contentType: .bookmarks)
        home.coordinator = self
        profile.coordinator = self
        bookmarks.coordinator = self
        home.title = "Home"
        profile.title = "Me"
        bookmarks.title = "Bookmarks"
        profile.tabBarItem.image = UIImage(systemName: "person.fill")
        bookmarks.tabBarItem.image = UIImage(systemName: "bookmark.fill")
        home.view.backgroundColor = .white
        profile.view.backgroundColor = .white
        bookmarks.view.backgroundColor = .white
        tabController.navigationItem.title = "Home"
        navigationController.navigationBar.prefersLargeTitles = true
        home.tabBarItem.image = UIImage(systemName: "house.fill")
        tabController.addChild(home)
        tabController.addChild(bookmarks)
        tabController.addChild(profile)
    }
    
    func goToUserSearch() {
        let userVC = ReusableMultiCellView(contentType: .users(.popularUsers))
        userVC.coordinator = self
        userVC.view.backgroundColor = .white
        userVC.title = "Users"
        navigationController.pushViewController(userVC, animated: true)
    }
    
    func goToReposSearch() {
        let reposVC = ReusableMultiCellView(contentType: .repos(.popularRepos))
        reposVC.coordinator = self
        reposVC.view.backgroundColor = .white
        reposVC.title = "Repositories"
        navigationController.pushViewController(reposVC, animated: true)
    }
    
    func goToCommitsView(_ targetRepo: String) {
        let commitsVC = ReusableMultiCellView(contentType: .commits(targetRepo))
        commitsVC.coordinator = self
        commitsVC.view.backgroundColor = .white
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
        reposVC.view.backgroundColor = .white
        reposVC.coordinator = self
        reposVC.title = "Repositories"
        navigationController.pushViewController(reposVC, animated: true)
    }
    
    func goToStarredRepositories(_ login: String) {
        let reposVC = ReusableMultiCellView(contentType: .repos(.starredRepos(login)))
        reposVC.view.backgroundColor = .white
        reposVC.coordinator = self
        reposVC.title = "Repositories"
        navigationController.pushViewController(reposVC, animated: true)
    }
    
}
