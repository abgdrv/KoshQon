//
//  Constants.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.03.2024.
//

import UIKit

enum Constants {
    
    static let url = ""
    static let authToken = "authToken"
    static var isExpired = false
    
    // MARK: - App
    
    enum App {
        static let name = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
        static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    // MARK: - Padding
    
    enum Padding {
        
    }
    
    // MARK: - PanModal
    
    enum PanModal {
        static let short = UIScreen.main.bounds.height * 0.15
        static let long = UIScreen.main.bounds.height * 0.6
        static let cornerRadius: CGFloat = 20
    }
    
    // MARK: - NotificationName
    
    enum NotificationName: String {
        case theme
        
        var name: Notification.Name {
            return Notification.Name(self.rawValue)
        }
    }
}
