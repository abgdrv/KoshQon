//
//  ProfileViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 15.03.2024.
//

import Foundation

enum ProfileType {
    case myProfile
    case userProfile
}

final class ProfileViewModel {
    
    // MARK: - Properties
    
    let profileType: ProfileType
    
    let user: User
    
    var items: [AnnouncementViewModel] = []
    
    private let ads: [Announcement] = [
        
    ]
    
    // MARK: - Object Lifecycle
    
    init(user: User, profileType: ProfileType) {
        self.user = profileType == .myProfile ? AppData.shared.user : user
        self.profileType = profileType
        getAnnouncements()
    }
}

// MARK: - Private methods

extension ProfileViewModel {
    func getAnnouncements() {
        items = makeCellViewModels(items: profileType == .myProfile ? AppData.shared.myAnnouncements : user.announcements)
    }
    
    func makeCellViewModels(items: [Announcement]) -> [AnnouncementViewModel] {
        return items.compactMap { AnnouncementViewModel(announcement: $0, isProfile: true) }
    }
}
