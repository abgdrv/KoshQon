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
        case star = "common/star"
        case checkbox = "common/checkbox"
        case checkboxSelected = "common/сheck"
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
        case defaultProfile = "personal/default"
    }
    
    // MARK: - Main

    enum Main: String, AppImageProtocol {
        case search = "main/search"
        case announcement = "main/announcement"
        case guide = "main/guide"
        case adBlank = "main/ad_blank"
    }
    
    // MARK: - Tabbar
    
    enum Tabbar: String, AppImageProtocol {
        case logo = "tabbar/logo"
        case logoSelected = "tabbar/logo_selected"
        case favorites = "tabbar/favorites"
        case favoritesSelected = "tabbar/favorites_selected"
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
    
    // MARK: - Profile
    
    enum Profile: String, AppImageProtocol {
        case good = "profile/good"
        case responsible = "profile/responsible"
        case clean = "profile/clean"
        case smoke = "profile/smoke"
        case alcohol = "profile/alcohol"
        case sport = "profile/sport"
        case pet = "profile/pet"
        case job = "profile/job"
        case student = "profile/student"
        case cook = "profile/cook"
        case religion = "profile/religion"
        case edit = "profile/edit"
        case settings = "profile/settings"
    }
    
    // MARK: - Settings
    
    enum Settings: String, AppImageProtocol {
        case personal = "settings/personal"
        case privacy = "settings/privacy"
        case theme = "settings/theme"
        case language = "settings/language"
        case about = "settings/about"
        case quit = "settings/quit"
        case deactivate = "settings/deactivate"
    }
    
    // MARK: - Friends
    
    enum Friends: String, AppImageProtocol {
        case more = "friends/more"
    }

}
