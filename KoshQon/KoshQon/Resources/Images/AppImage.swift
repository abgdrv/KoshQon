//
//  AppImage.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 18.02.2024.
//

import Foundation

enum AppImage: String, AppImageProtocol {
    
    // MARK: - Common
    
    case AppIcon
    
    // MARK: - Auth
    
    case eyeOn = "auth/eye_on"
    case eyeOff = "auth/eye_off"
    case checkbox = "auth/checkbox"
    case checkboxFilled = "auth/checkbox_filled"
    case calendar = "auth/calendar"
    case expandDown = "auth/expand_down"
    
    // MARK: -
    
}
