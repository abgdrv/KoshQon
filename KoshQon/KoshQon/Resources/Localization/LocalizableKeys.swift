//
//  LocalizableKeys.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 27.05.2024.
//

import Foundation

enum LocalizableKeys {
    
    enum App: String {
        case version = "version"
    }
    
    enum InfoLabel: String {
        case phoneNumber = "phone_number"
        case password = "password"
        case noAccount = "no_account"
        case createPassword = "create_password"
        case repeatPassword = "repeat_password"
        case verificationCodeSent = "verification_code_sent"
        case resendAfter = "resend_after"
        case passwordMustContain = "password_must_contain"
        case atLeastEightDigits = "at_least_eight_digits"
        case digits = "digits"
        case capitalAndLowercaseLetter = "capital_lowercase_letters"
        case phoneNumberLogin = "phone_number_login"
        case phoneNumberRecover = "phone_number_recover"
        case phoneNumberAccount = "phone_number_account"
        case clickHeart = "click_heart"
        case empty = "empty"
    }
    
    enum ProceedButton: String {
        case signIn = "sign_in"
        case createAccount = "create_account"
        case `continue` = "continue"
        case changePassword = "change_password"
        case edit = "edit"
        case searchAnnouncements = "search_announcements"
        case goToPage = "go_to_page"
        case save = "save"
    }
    
    enum NavigationBar: String {
        case forgotPassword = "forgot_password"
        case confirmationCode = "confirmation_code"
        case passwordCreation = "password_creation"
        case personalInfo = "personal_info"
        case favorites = "favorites"
        case messages = "messages"
        case profile = "profile"
        case friends = "friends"
        case settings = "settings"
        case myAnnouncements = "my_announcements"
        case changePhoneNumber = "change_phone_number"
        case aboutMe = "about_me"
        case confidentiality = "confidentiality"
        case appTheme = "app_theme"
        case characteristics = "characteristics"
        case add = "add_announcement"
        case language = "language"
    }
    
    enum Helpers: String {
        case countryCode = "country_code"
        case gender = "gender"
        case country = "country"
        case city = "city"
    }
    
    enum ActionButton: String {
        case write = "write"
        case call = "call"
    }
    
    enum Profile: String {
        case aboutPlaceholder = "about_placeholder"
        case generalInfo = "general_info"
        case rating = "rating"
        case announcements = "announcements"
        case fullName = "full_name"
    }
    
    enum Plural: String {
        case yearSingular = "year_singular"
        case yearPlural = "year_plural"
        case yearsPlural = "years_plural"
    }
    
    enum Main: String {
        case recentAnnouncements = "recent_announcements"
    }
    
    enum NavigationCell: String {
        case find = "find"
        case guide = "guide"
        case aboutApp = "about_app"
        case quit = "quit"
        case deactivateAccount = "deactivate_account"
        case themeLight = "theme_light"
        case themeDark = "theme_dark"
        case themeSystem = "theme_system"
        case kz = "language_kz"
        case ru = "language_ru"
        case en = "language_en"
        case removeConnection = "remove_connection"
    }
    
    enum PassCode: String {
        case enter = "enter_access_code"
        case confirm = "confirm_access_code"
    }
    
    enum Auth: String {
        case forgotPassword = "forgot_password"
        case signUp = "sign_up"
        case fname = "first_name"
        case lname = "last_name"
        case enterPaasword = "enter_password"
        case birthday = "birthday"
        case enterPhone = "enter_phone"
    }
    
    enum Alert: String {
        case error = "error"
        case emptyFields = "empty_fields"
        case incorrectPhone = "incorrect_phone_number"
        case incorrectPassword = "incorrect_password"
        case delete = "delete"
        case cancel = "cancel"
        case deleteFavorites = "delete_favorites"
        case share = "share"
        case camera = "camera"
        case gallery = "gallery"
        case close = "close"
        case look = "look"
        case deletePhoto = "delete_photo"
        case selectPhoto = "select_photo"
        case selectPhotoOrOpenCamera = "select_photo_open_camera"
        case unableToLoadAlbum = "load_album_fail"
        case enableAccessInSettings = "enable_access_settings"
        case deactivate = "deactivate"
        case deactivateAccount = "deactivate_account"
        case changeName = "change_name"
        case support = "support"
        case phoneChanged = "phone_number_changed"
    }
    
    enum AddAnnouncement: String {
        case newAnnouncement = "new_announcement"
        case residencePlace = "residence_place"
        case addPhoto = "add_photo"
    }
}

extension RawRepresentable where RawValue == String {
    func localized() -> String {
        return rawValue.localized
    }
}
