//
//  MainScreenViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 12.03.2024.
//

import Foundation

final class MainScreenViewModel {
    
    // MARK: - Properties
    
    var adViewModels: [AnnouncementViewModel] = []
    var navigationItemViewModels: [MainNavigationCellViewModel] = []
    
    let navigationItems = MainNavigationType.allCases
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
    
    private func makeNavigationCellViewModels(items: [MainNavigationType]) -> [MainNavigationCellViewModel] {
        return items.compactMap { MainNavigationCellViewModel(type: $0) }
    }
}

// MARK: - Request

private extension MainScreenViewModel {
    func getAnnouncements() {
        adViewModels = makeAnnouncementCellViewModels(items: ads)
    }
    
    func getNavigationItems() {
        navigationItemViewModels = makeNavigationCellViewModels(items: navigationItems)
    }
}
