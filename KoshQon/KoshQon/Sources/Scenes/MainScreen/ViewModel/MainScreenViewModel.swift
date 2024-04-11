//
//  MainScreenViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 12.03.2024.
//

import Foundation

final class MainScreenViewModel {
    
    // MARK: - Properties
    
    var announcementViewModels: [AnnouncementViewModel] = []
    var navigationCellViewModels: [NavigationCellViewModel] = []
    
    let navigationItems: [NavigationCellType] = NavigationCellType.Main.allCases.map { NavigationCellType.main($0) }
    let ads = [
        Announcement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7),
        Announcement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7),
        Announcement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7),
        Announcement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7)
    ]
    
    // MARK: - Object Lifecycle
    
    init() {
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
