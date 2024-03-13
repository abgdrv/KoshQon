//
//  AppImage.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 18.02.2024.
//

import Foundation

enum AppImage {
    
    // MARK: - Common
    
    enum Common: String, AppImageProtocol {
        case AppIcon
        case backArrow = "common/back_arrow"
        case expandRight = "common/expand_right"
    }
    
    // MARK: - Auth
    
    enum Auth: String, AppImageProtocol {
        case eyeOn = "auth/eye_on"
        case eyeOff = "auth/eye_off"
        case checkbox = "auth/checkbox"
        case checkboxFilled = "auth/checkbox_filled"
        case calendar = "auth/calendar"
        case expandDown = "auth/expand_down"
        case clear = "auth/clear"
    }
    
    // MARK: - Personal

    enum Personal: String, AppImageProtocol {
        case plus = "personal/plus"
    }
    
    // MARK: - Main

    enum Main: String, AppImageProtocol {
        case search = "main/search"
        case advertisement = "main/advertisement"
        case guide = "main/guide"
        case adBlank = "main/ad_blank"
        case star = "main/star"
    }
    
    // MARK: - Tabbar
    
    enum Tabbar: String, AppImageProtocol {
        case logo = "tabbar/logo"
        case logoSelected = "tabbar/logo_selected"
        case favourites = "tabbar/favourites"
        case favouritesSelected = "tabbar/favourites_selected"
        case add = "tabbar/add"
        case messages = "tabbar/messages"
        case messagesSelected = "tabbar/messages_selected"
        case profile = "tabbar/profile"
        case profileSelected = "tabbar/profile_selected"
    }
    
    // MARK: - Favorites
    
    enum Favorites: String, AppImageProtocol {
        case heart = "favorites/heart"
    }
}
