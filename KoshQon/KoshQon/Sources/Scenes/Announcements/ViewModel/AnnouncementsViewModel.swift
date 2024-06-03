//
//  AnnouncementsViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 12.03.2024.
//

import Foundation

final class AnnouncementsViewModel {
    
    // MARK: - Properties
    
    let type: AnnouncementsType
    var items: [AnnouncementViewModel] = []
    
    // MARK: - Object Lifecycle
    
    init(type: AnnouncementsType) {
        self.type = type
        getAnnouncements()
    }
}

// MARK: - Private methods

extension AnnouncementsViewModel {
    func getAnnouncements() {
        items = makeCellViewModels(items: type == .favorites ? AppData.shared.favorites : AppData.shared.myAnnouncements)
    }
    
    func makeCellViewModels(items: [Announcement]) -> [AnnouncementViewModel] {
        return items.compactMap { AnnouncementViewModel(announcement: $0) }
    }
}
