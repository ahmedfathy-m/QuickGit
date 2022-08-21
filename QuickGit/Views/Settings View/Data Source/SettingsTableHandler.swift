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
        case .general:
            cell.sectionType = SettingsOptions.GeneralSettings(rawValue: indexPath.row)
            cell.cellSwitch.isOn = UserDefaults.standard.bool(forKey: "DarkModeEnabled")
            cell.switchAction = {
                let window = cell.window
                if cell.cellSwitch.isOn {
                    UserDefaults.standard.set(true, forKey: "DarkModeEnabled")
                    window?.backgroundColor = .black
                    window?.overrideUserInterfaceStyle = .dark
                } else {
                    UserDefaults.standard.set(false, forKey: "DarkModeEnabled")
                    window?.backgroundColor = .white
                    window?.overrideUserInterfaceStyle = .light
                }
            }
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
        let parentVC = tableView.parentViewController
        let section = SettingsOptions(rawValue: indexPath.section)
        switch section {
        case .general:
            let cell = SettingsOptions.GeneralSettings(rawValue: indexPath.row)
            switch cell {
            case .clearBookmarks:
                let alert = UIAlertController(title: "Warning", message: "This option will delete all locally bookmarked items.\n Are you Sure?", preferredStyle: .actionSheet)
                let action = UIAlertAction(title: "Yes", style: .default) { _ in
                    do {
                        try CoreDataHelper.shared.clearData()
                    } catch {
                        print(error)
                    }
                }
                let cancel = UIAlertAction(title: "No", style: .cancel) { _ in
                    return
                }
                alert.addAction(action)
                alert.addAction(cancel)
                parentVC?.present(alert, animated: true)
            default: break
            }
        default: break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
