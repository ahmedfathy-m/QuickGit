//
//  ProfileTableHandler.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 13/08/2022.
//

import UIKit

class ProfileTableHandler: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfilePageOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.identifier, for: indexPath) as! OptionCell
        cell.sectionType = ProfilePageOptions(rawValue: indexPath.row)
        return cell
    }
}

extension ProfileTableHandler: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let parentVC = tableView.parentViewController as! ProfileViewController
        let selectedOption = ProfilePageOptions(rawValue: indexPath.row)
        switch selectedOption {
        case .repos: parentVC.goToUsersRepos()
        case .starred: parentVC.goToUsersRepos()
        case .organization: break
        case .none: break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: UserHeaderView.identifier) as! UserHeaderView
        header.avatar.image = UIImage(named: "me")
        header.displayName.text = "Ahmed Fathy"
        header.bookmarkButton.isHidden = true
        header.buttonAction = {
            print("Really")
        }
        return header
    }
}
