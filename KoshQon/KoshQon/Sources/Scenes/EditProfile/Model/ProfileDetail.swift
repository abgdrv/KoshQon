//
//  ProfileDetail.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import Foundation

struct ProfileDetail {
    let type: ProfileDetailType
    var value: [String]
    
    var title: String {
        switch type {
        case .name:
            return LocalizableKeys.Profile.fullName.localized()
        case .birthday:
            return LocalizableKeys.Auth.birthday.localized()
        case .gender:
            return LocalizableKeys.Helpers.gender.localized()
        case .phone:
            return LocalizableKeys.InfoLabel.phoneNumber.localized()
        case .country:
            return LocalizableKeys.Helpers.country.localized()
        case .city:
            return LocalizableKeys.Helpers.city.localized()
        case .characteristics:
            return LocalizableKeys.NavigationBar.characteristics.localized()
        case .about:
            return LocalizableKeys.NavigationBar.aboutMe.localized()
        }
    }
    
    var isEditable: Bool {
        switch type {
        case .name:
            false
        default:
            true
        }
    }

}
