//
//  SettingsTableHandler.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 13/08/2022.
//

import UIKit

class SettingsTableHandler: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = SettingsOptions(rawValue: section)
        switch section {
        case .general: return SettingsOptions.GeneralSettings.allCases.count
        case .policy: return SettingsOptions.PolicyOptions.allCases.count
        case .language: return SettingsOptions.LocaleOptions.allCases.count
        case .account: return SettingsOptions.AccountOptions.allCases.count
        case .none: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.identifier, for: indexPath) as! OptionCell
        cell.backgroundColor = .lightGray.withAlphaComponent(0.3)
        let section = SettingsOptions(rawValue: indexPath.section)
        switch section {
        case .general: cell.sectionType = SettingsOptions.GeneralSettings(rawValue: indexPath.row)
        case .policy: cell.sectionType = SettingsOptions.PolicyOptions(rawValue: indexPath.row)
        case .language: cell.sectionType = SettingsOptions.LocaleOptions(rawValue: indexPath.row)
        case .account: cell.sectionType = SettingsOptions.AccountOptions(rawValue: indexPath.row)
        case .none: break
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsOptions.allCases.count
    }
    
}

extension SettingsTableHandler: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}