//
//  NavigationCellType.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import Foundation

enum NavigationCellType: CaseIterable {
    case main(Main)
    case settings(Settings)
    case privacy(Privacy)
    case theme(Theme)
    case language(Language)
    case more(More)
    
    static var allCases: [NavigationCellType] {
        var cases: [NavigationCellType] = []
        cases.append(contentsOf: Main.allCases.map { NavigationCellType.main($0) })
        cases.append(contentsOf: Settings.allCases.map { NavigationCellType.settings($0) })
        cases.append(contentsOf: Privacy.allCases.map { NavigationCellType.privacy($0) })
        cases.append(contentsOf: Theme.allCases.map { NavigationCellType.theme($0) })
        cases.append(contentsOf: Language.allCases.map { NavigationCellType.language($0) })
        cases.append(contentsOf: More.allCases.map { NavigationCellType.more($0) })
        return cases
    }
    
    enum Main: String, CaseIterable {
        case search
        case myAnnouncements
        case guide
    }
    
    enum Settings: String, CaseIterable {
        case personal
        case privacy
        case theme
        case language
        case about
        case quit
    }
    
    enum Privacy: String, CaseIterable {
        case deactivate
    }
    
    enum Theme: String, CaseIterable {
        case light
        case dark
        case system
        
        var appTheme: AppTheme {
            switch self {
            case .light:
                return .light
            case .dark:
                return .dark
            case .system:
                return .phone
            }
        }
    }
    
    enum Language: String, CaseIterable {
        case kazakh
        case russian
        case english
        
        var languageType: LanguageType {
            switch self {
            case .kazakh:
                return .kz
            case .russian:
                return .ru
            case .english:
                return .en
            }
        }
    }
    
    enum More: String, CaseIterable {
        case unfriend
        case write
        case call
    }
}

extension NavigationCellType {
    var associatedCases: [NavigationCellType] {
        switch self {
        case .main:
            return Main.allCases.map { NavigationCellType.main($0) }
        case .settings:
            return Settings.allCases.map { NavigationCellType.settings($0) }
        case .privacy:
            return Privacy.allCases.map { NavigationCellType.privacy($0) }
        case .theme:
            return Theme.allCases.map { NavigationCellType.theme($0) }
        case .language:
            return Language.allCases.map { NavigationCellType.language($0) }
        case .more:
            return More.allCases.map { NavigationCellType.more($0) }
        }
    }
}
