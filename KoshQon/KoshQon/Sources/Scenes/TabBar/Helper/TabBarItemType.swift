//
//  TabBarItemType.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 25.03.2024.
//

import Foundation
import UIKit

enum TabBarItemType: Int, CaseIterable {
    private typealias Image = AppImage.Tabbar
    
    case main = 0
    case favorites = 1
    case add = 2
    case messages = 3
    case profile = 4
    
    var title: String {
        switch self {
        case .main:
            Constants.App.name ?? ""
        case .favorites:
            "Избранное"
        case .add:
            "Подать"
        case .messages:
            "Сообщения"
        case .profile:
            "Профиль"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .main:
            Image.logo.uiImage
        case .favorites:
            Image.favorites.uiImage
        case .add:
            Image.add.uiImage?.withRenderingMode(.alwaysOriginal)
        case .messages:
            Image.messages.uiImage
        case .profile:
            Image.profile.uiImage
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .main:
            Image.logoSelected.uiImage
        case .favorites:
            Image.favoritesSelected.uiImage
        case .add:
            Image.add.uiImage?.withRenderingMode(.alwaysOriginal)
        case .messages:
            Image.messagesSelected.uiImage
        case .profile:
            Image.profileSelected.uiImage
        }
    }
}
