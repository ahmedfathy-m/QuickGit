//
//  ProfilePageOptions.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 13/08/2022.
//

import UIKit

enum ProfilePageOptions: Int, CaseIterable, OptionType {
    case repos
    case starred
    case organization
    
    var description: String {
        switch self {
            case .repos: return "Repositories"
            case .starred: return "Starred"
            case .organization: return "Organization"
        }
    }
    
    var hasSwitch: Bool {
        return false
    }
    
    var icon: UIImage? {
        let image: UIImage?
        switch self {
        case .repos: image = UIImage(named: "repository")
            case .starred: image = UIImage(systemName: "star")
            case .organization: image = UIImage(systemName: "teletype")
        }
        let inset = 4.0
        return image?.imageWithInsets(insets: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))?.withRenderingMode(.alwaysTemplate)
    }
    
    var iconColor: UIColor? {
        switch self {
        case .repos: return UIColor.systemBlue
        case .starred: return UIColor.systemYellow
        case .organization: return UIColor.systemOrange
        }
    }
    
}
