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
    let navigationItems: [NavigationCellType] = Array(NavigationCellType.allCases.dropFirst(3))
    
    // MARK: - Object Lifecycle
    
    init() {
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
