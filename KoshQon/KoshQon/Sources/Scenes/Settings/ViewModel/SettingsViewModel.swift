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
            Array(NavigationCellType.allCases[3..<9])
        case .privacy:
            Array(NavigationCellType.allCases[9..<10])
        case .theme:
            Array(NavigationCellType.allCases[10..<13])
        case .language:
            Array(NavigationCellType.allCases[13..<16])
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
