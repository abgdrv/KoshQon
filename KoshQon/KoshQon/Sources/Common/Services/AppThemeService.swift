//
//  AppThemeService.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.03.2024.
//

import Foundation
import UIKit

protocol AppThemeServiceProtocol {
    func getCurrentTheme() -> Theme
    func updateThemeState(with theme: Theme)
    func getUserInterfaceStyle() -> UIUserInterfaceStyle
}

enum Theme: String, CaseIterable {
    case light
    case dark
    case phone
    
    var title: String {
        switch self {
        case .light:
            "Светлая"
        case .dark:
            "Темная"
        case .phone:
            "Системная"
        }
    }
}

final class AppThemeService {
    
    // MARK: - Properties
    
    static let shared = AppThemeService(userDefaultsService: UserDefaultsService.shared)
    private let userDefaultsService: UserDefaultsServiceProtocol
    
    // MARK: - Object Lifecycle
    
    private init(userDefaultsService: UserDefaultsServiceProtocol) {
        self.userDefaultsService = userDefaultsService
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleSystemChange),
                                               name: Constants.NotificationNameConstants.theme.name,
                                               object: nil)
    }
    
    // MARK: - Private methods
    
    private func applySystemTheme() {
        let deviceTheme = UIScreen.main.traitCollection.userInterfaceStyle
        
        if deviceTheme == .dark {
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .dark
        } else {
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .light
        }
    }
}

// MARK: - AppThemeServiceProtocol

extension AppThemeService: AppThemeServiceProtocol {
    func getUserInterfaceStyle() -> UIUserInterfaceStyle {
        switch getCurrentTheme() {
        case .dark:
            return .dark
        case .light:
            return .light
        case .phone:
            return UIScreen.main.traitCollection.userInterfaceStyle
        }
    }
    
    func getCurrentTheme() -> Theme {
        if let themeRawValue = userDefaultsService.value(for: UserDefaultsKey.theme.key) as? String,
           let theme = Theme(rawValue: themeRawValue) {
            return theme
        }
        return .phone
    }
    
    func updateThemeState(with theme: Theme) {
        let window = UIApplication.shared.keyWindow ?? UIWindow()
        
        UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve, animations: {
            switch theme {
            case .light:
                window.overrideUserInterfaceStyle = .light
            case .dark:
                window.overrideUserInterfaceStyle = .dark
            case .phone:
                self.applySystemTheme()
            }
        }, completion: nil)
        
        userDefaultsService.set(value: theme.rawValue, for: UserDefaultsKey.theme.key)
    }
}

// MARK: - Actions

private extension AppThemeService {
    @objc func handleSystemChange() {
        if getCurrentTheme() == .phone {
            updateThemeState(with: .phone)
        }
    }
}
