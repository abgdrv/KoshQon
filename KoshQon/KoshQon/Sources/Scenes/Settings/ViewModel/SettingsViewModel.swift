//
//  SettingsViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import Foundation

final class SettingsViewModel {
    
    // MARK: - Properties
    
    var navigationCellViewModels: [NavigationCellViewModel] = []
    
    private let type: NavigationTableViewType
    
    private var navigationItems: [NavigationCellType] {
        switch type {
        case .settings:
            NavigationCellType.Settings.allCases.map { NavigationCellType.settings($0) }
        case .privacy:
            NavigationCellType.Privacy.allCases.map { NavigationCellType.privacy($0) }
        case .theme:
            NavigationCellType.Theme.allCases.map { NavigationCellType.theme($0) }
        case .language:
            NavigationCellType.Language.allCases.map { NavigationCellType.language($0) }
        }
    }
    
    // MARK: - Object Lifecycle
    
    init(type: NavigationTableViewType) {
        self.type = type
        getNavigationItems()
    }
}

// MARK: - Private methods

private extension SettingsViewModel {
    func getNavigationItems() {
        navigationCellViewModels = makeNavigationCellViewModels(items: navigationItems)
    }
    
    func makeNavigationCellViewModels(items: [NavigationCellType]) -> [NavigationCellViewModel] {
        return items.compactMap { NavigationCellViewModel(type: $0) }
    }
}
