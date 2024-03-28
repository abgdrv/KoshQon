//
//  AppColor.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 17.02.2024.
//

import Foundation

enum AppColor {
    
    // MARK: - Static
    
    enum Static: String, AppColorProtocol {
        case black = "static/black"
        case white = "static/white"
        case darkBlue = "static/blue_dark"
        case lightBlue = "static/blue_light"
        case darkGray = "static/gray_dark"
        case lightGray = "static/gray_light"
        case green = "static/green"
        case orange = "static/orange"
        case darkRed = "static/red_dark"
        case lightRed = "static/red_light"
        case yellow = "static/yellow"
    }
    
    // MARK: - Theme
    
    enum Theme: String, AppColorProtocol {
        case mainBackground = "theme/main_background"
        case mainTitle = "theme/main_title"
        case secondaryBackground = "theme/secondary_background"
        case secondaryTitle = "theme/secondary_title"
        case blockBackground = "theme/block_background"
        case separation = "theme/separation"
    }
}
