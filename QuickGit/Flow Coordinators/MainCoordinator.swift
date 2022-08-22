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
//        let bookmarks = ReusableMultiCellView(contentType: .bookmarks)
        let bookmarks = BookmarksView()
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
        let usersVC = UsersListView()
        usersVC.coordinator = self
        navigationController.pushViewController(usersVC, animated: true)
    }
    
    func goToReposSearch() {
        let reposVC = ReposListView()
        reposVC.coordinator = self
        navigationController.pushViewController(reposVC, animated: true)
    }
    
    func goToCommitsView(_ targetRepo: String) {
        let commitsVC = CommitsListView()
        commitsVC.viewModel = CommitViewModel(repoName: targetRepo)
        commitsVC.coordinator = self
        navigationController.pushViewController(commitsVC, animated: true)
    }
    
    func goToUser(with name: String?) {
        let viewModel = ProfileViewModel(with: name)
        let userVC = ProfileViewController(viewModel: viewModel)
        userVC.navigationItem.largeTitleDisplayMode = .never
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
        let reposVC = ReposListView()
        reposVC.viewModel = RepositoriesViewModel(by: login)
        reposVC.doesHaveSearchBar = false
        reposVC.coordinator = self
        reposVC.navigationItem.largeTitleDisplayMode = .always
        navigationController.pushViewController(reposVC, animated: true)
    }
    
    func goToStarredRepositories(_ login: String) {
        let reposVC = ReposListView()
        reposVC.viewModel = RepositoriesViewModel(starredBy: login)
        reposVC.doesHaveSearchBar = false
        reposVC.coordinator = self
        reposVC.navigationItem.largeTitleDisplayMode = .always
        navigationController.pushViewController(reposVC, animated: true)
    }
    
    func searchUsersWithQuery(_ query: String) {
        let usersVC = UsersListView()
        usersVC.coordinator = self
        usersVC.searchController.searchBar.text = query
        navigationController.pushViewController(usersVC, animated: true)
        usersVC.triggerSearchAction(using: usersVC.searchController.searchBar)
    }
    
    func searchReposWithQuery(_ query: String) {
        let reposVC = ReposListView()
        reposVC.coordinator = self
        reposVC.searchController.searchBar.text = query
        navigationController.pushViewController(reposVC, animated: true)
        reposVC.triggerSearchAction(using: reposVC.searchController.searchBar)
    }
    
    func returnToLogin() {
        print(parentCoordinator)
        parentCoordinator?.authCoordinator.start()
    }
    
}
