//
//  HomeTableDataModel.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 12/08/2022.
//

import UIKit

protocol OptionType : CustomStringConvertible {
    var hasSwitch: Bool { get }
    var icon: UIImage? { get }
    var iconColor: UIColor? { get }
}

enum HomeSectionModel: Int, CaseIterable, CustomStringConvertible {
    case Features
    case Repos
    case Mode
    
    var description: String {
        switch self {
        case .Features: return "Features"
        case .Repos: return "Repos"
        case .Mode: return "Mode"
        }
    }
    
    enum FeaturesSection: Int, CaseIterable, OptionType {
        case users
        case repos
        case issues
        case gitweb
        
        var description: String {
            switch self {
            case .users: return "Users"
            case .repos: return "Repositories"
            case .issues: return "Issues"
            case .gitweb: return "Github Web"
            }
        }
        
        var hasSwitch: Bool {
            return false
        }
        
        var icon: UIImage? {
            var image: UIImage?
            switch self {
            case .users: image = UIImage(systemName: "person")
            case .repos: image = UIImage(named: "repository")
            case .issues: image = UIImage(systemName: "exclamationmark.circle")
            case .gitweb: image = UIImage(named: "github")
            }
            let inset = 4.0
            return image?.imageWithInsets(insets: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))?.withRenderingMode(.alwaysTemplate)
        }
        
        var iconColor: UIColor? {
            switch self {
            case .users: return UIColor.lightGray
            case .repos: return UIColor.systemBlue
            case .issues: return UIColor.systemGreen
            case .gitweb: return UIColor.systemRed
            }
        }
    }
    
    enum ReposSection: Int, CaseIterable, OptionType {
        case repo
        
        var description: String {
            switch self {
            case .repo:
                if CoreDataHelper.shared.bookmarkedRepos.count > 0 {
                    return CoreDataHelper.shared.bookmarkedRepos[0].repoName ?? "My Repo"
                }
                return "My Repo"
            }
        }
        
        var hasSwitch: Bool {
            return false
        }
        
        var icon: UIImage? {
            return nil
        }
        
        var iconColor: UIColor? {
            return nil
        }
    }
    
    enum ModeSection: Int, CaseIterable, OptionType {
        case mode
        
        var description: String {
            switch self {
            case .mode: return AppCoordinator.userMode.rawValue
            }
        }
        
        var hasSwitch: Bool {
            return false
        }
        
        var icon: UIImage? {
            return nil
        }
        
        var iconColor: UIColor? {
            return nil
        }
    }
}
