//
//  AnnouncementDetailsViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 02.06.2024.
//

import UIKit

final class AnnouncementDetailsViewModel: ObservableObject {
    
    let announcement: Announcement
    
    var didProfileTap: Callback<User>?
    
    @Published var isFavorite: Bool
    
    init(announcement: Announcement) {
        self.announcement = announcement
        self.isFavorite = AppData.shared.favorites.contains(announcement)
    }
    
    func call() {
        print(announcement.user.phoneNumber)
        if let url = URL(string: "tel://\(announcement.user.phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
}

