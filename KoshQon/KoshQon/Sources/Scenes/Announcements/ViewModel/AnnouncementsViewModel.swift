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
