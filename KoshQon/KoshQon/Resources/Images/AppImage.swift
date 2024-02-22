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
    
}
