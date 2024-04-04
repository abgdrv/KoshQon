//
//  NavigationCellType.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import Foundation

enum NavigationCellType: String, CaseIterable {
    case search
    case myAnnouncements
    case guide
    
    case personal
    case privacy
    case theme
    case language
    case about
    case quit
    
    case deactivate
    
    case themeLight
    case themeDark
    case themeDefault
    
    case languageKazakh
    case languageRussian
    case languageEnglish
    
    var theme: Theme {
        switch self {
        case .themeLight:
            .light
        case .themeDark:
            .dark
        case .themeDefault:
            .phone
        default:
            .phone
        }
    }
}
