//
//  HomeTableViewHandler.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 10/08/2022.
//

import UIKit

class HomeTableViewHandler: NSObject, UITableViewDataSource {
    weak var superView: HomeViewController?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeSectionModel.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = HomeSectionModel(rawValue: section) else { return 0 }
        
        switch section {
        case .Features: return HomeSectionModel.FeaturesSection.allCases.count
        case .Repos: return HomeSectionModel.ReposSection.allCases.count
        case .Mode: return HomeSectionModel.ModeSection.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.identifier, for: indexPath) as! OptionCell
        cell.backgroundColor = .lightGray.withAlphaComponent(0.3)
        cell.accessoryType = .disclosureIndicator
        guard let section = HomeSectionModel(rawValue: indexPath.section) else { return cell }
        
        switch section {
        case .Features: cell.sectionType = HomeSectionModel.FeaturesSection(rawValue: indexPath.row)
        case .Repos: cell.sectionType = HomeSectionModel.ReposSection(rawValue: indexPath.row)
        case .Mode: cell.sectionType = HomeSectionModel.ModeSection(rawValue: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return HomeSectionModel(rawValue: section)?.description
    }
}

extension HomeTableViewHandler: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let homeVC = tableView.parentViewController as! HomeViewController
        
        guard let section = HomeSectionModel(rawValue: indexPath.section) else { return }
        
        switch section {
        case .Features:
            guard let item = HomeSectionModel.FeaturesSection(rawValue: indexPath.row) else { return }
            switch item {
            case .users: homeVC.usersButtonPressed()
            case .repos: homeVC.repoButtonPressed()
            case .issues: break
            case .gitweb: UIApplication.shared.open(URL(string: "https://github.com/")!)
            }
        case .Repos: break
        case .Mode: break
        }
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.parentViewController
        } else {
            return nil
        }
    }
}
