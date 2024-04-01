//
//  AnnouncementsViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 12.03.2024.
//

import Foundation

final class AnnouncementsViewModel {
    
    // MARK: - Properties
    
    private let type: AnnouncementsType
    var items: [AnnouncementViewModel] = []
    
    let ads: [Announcement] = [
        Announcement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7),
        Announcement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7),
        Announcement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7),
        Announcement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7)
    ]
    
    // MARK: - Object Lifecycle
    
    init(type: AnnouncementsType) {
        self.type = type
        getAnnouncements()
    }

}

// MARK: - Private methods

private extension AnnouncementsViewModel {
    func getAnnouncements() {
        items = makeCellViewModels(items: ads)
    }
    
    func makeCellViewModels(items: [Announcement]) -> [AnnouncementViewModel] {
        return items.compactMap { AnnouncementViewModel(announcement: $0) }
    }
}
