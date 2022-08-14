//
//  SettingsViewDataModel.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 13/08/2022.
//

import UIKit

enum SettingsOptions: Int, CaseIterable, CustomStringConvertible {
    case general
    case policy
    case language
    case account
    
    var description: String {
        switch self {
        case .general: return "General"
        case .policy: return "Policy"
        case .language: return "Language"
        case .account: return "Account"
        }
    }
    
    enum GeneralSettings: Int, CaseIterable, OptionType {
        case darkMode
        case clearHistory
        case clearBookmarks
        
        var description: String {
            switch self {
            case .darkMode: return "Dark Mode"
            case .clearHistory: return "Clear All Records"
            case .clearBookmarks: return "Clear All Bookmarks"
            }
        }
        
        var icon: UIImage? { return nil }
        var iconColor: UIColor? { return nil }
        
        var hasSwitch: Bool {
            switch self {
            case .darkMode: return true
            case .clearHistory: return false
            case .clearBookmarks: return false
            }
        }
        
        
    }
    
    enum PolicyOptions: Int, CaseIterable, OptionType {
        var hasSwitch: Bool { return false }
        
        var icon: UIImage? { return nil }
        
        var iconColor: UIColor? { return nil }
        
        var description: String {
            switch self {
            case .policy: return "Privacy Policy"
            case .terms: return "Terms of use"
            }
        }
        
        case policy
        case terms
    }
    
    enum LocaleOptions: Int, CaseIterable, OptionType {
        var hasSwitch: Bool { return false }
        
        var icon: UIImage? { return nil }
        
        var iconColor: UIColor? { return nil }
        
        var description: String { switch self {
        case .arabic: return "Switch To Arabic"
        }}
        
        case arabic
        
    }
    
    enum AccountOptions: Int, CaseIterable, OptionType {
        var hasSwitch: Bool { return false }
        
        var icon: UIImage? { return nil }
        
        var iconColor: UIColor? { return nil }
        
        var description: String { switch self {
        case .logout:
            return "Log Out"
        }}
        
        case logout
    }
}
