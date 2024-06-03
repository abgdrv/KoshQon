//
//  MainScreenViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 12.03.2024.
//

import Foundation

final class MainScreenViewModel {
    
    // MARK: - Properties
    
    let isFirst: Bool
    
    var announcementViewModels: [AnnouncementViewModel] = []
    var navigationCellViewModels: [NavigationCellViewModel] = []
    
    let navigationItems: [NavigationCellType] = NavigationCellType.Main.allCases.map { NavigationCellType.main($0) }
    let ads: [Announcement] = AppData.shared.announcements
    
    // MARK: - Object Lifecycle
    
    init(isFirst: Bool) {
        self.isFirst = isFirst
        getAnnouncements()
        getNavigationItems()
    }
    
    // MARK: - Private methods
    
    private func makeAnnouncementCellViewModels(items: [Announcement]) -> [AnnouncementViewModel] {
        return items.compactMap { AnnouncementViewModel(announcement: $0) }
    }
    
    private func makeNavigationCellViewModels(items: [NavigationCellType]) -> [NavigationCellViewModel] {
        return items.compactMap { NavigationCellViewModel(type: $0) }
    }
}

// MARK: - Request

private extension MainScreenViewModel {
    func getAnnouncements() {
        announcementViewModels = makeAnnouncementCellViewModels(items: ads)
    }
    
    func getNavigationItems() {
        navigationCellViewModels = makeNavigationCellViewModels(items: navigationItems)
    }
}
