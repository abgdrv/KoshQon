//
//  AnnouncementViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 12.03.2024.
//

import UIKit

protocol IAnnouncementCellViewModel {
    var title: String { get }
    var address: String { get }
    var date: String { get }
}

final class AnnouncementViewModel {
    let announcement: Announcement
    let isProfile: Bool
    
    init(announcement: Announcement, isProfile: Bool = false) {
        self.announcement = announcement
        self.isProfile = isProfile
    }
}

extension AnnouncementViewModel: IAnnouncementCellViewModel {
    var title: String {
        announcement.title
    }
    
    var address: String {
        announcement.address
    }
    
    var condtion: String {
        announcement.condition.title
    }
    
    var age: String {
        return "\(announcement.age.0) - \(announcement.age.1)"
    }
    
    var gender: String {
        return announcement.gender.title
    }
    
    var budget: String {
        return "\(announcement.budget.0) - \(announcement.budget.1)"
    }
    
    var date: String {
        announcement.date.toString(format: "d MMMM")
    }
    
    var mainImage: UIImage? {
        if announcement.images.isEmpty {
            return nil
        }
        return announcement.images[0]
    }
}
