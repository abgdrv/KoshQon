//
//  ProfileDetailType.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import Foundation

enum ProfileDetailType: String, CaseIterable {
    case name
    case birthday
    case gender
    case phone
    case country
    case city
    case characteristics
    case about
    
    var menuType: MenuType? {
        switch self {
        case .gender:
            .gender
        case .country:
            .country
        case .city:
            .city
        default:
            nil
        }
    }
}
