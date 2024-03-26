//
//  AnnouncementViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 12.03.2024.
//

import Foundation

protocol IAnnouncementCellViewModel {
    var title: String { get }
    var address: String { get }
    var date: String { get }
    var rating: String { get }
}

final class AnnouncementViewModel {
    let announcement: Announcement
    
    init(announcement: Announcement) {
        self.announcement = announcement
    }
}

extension AnnouncementViewModel: IAnnouncementCellViewModel {
    var title: String {
        announcement.title
    }
    
    var address: String {
        announcement.address
    }
    
    var date: String {
        announcement.date
    }
    
    var rating: String {
        "\(announcement.rating)"
    }
}
