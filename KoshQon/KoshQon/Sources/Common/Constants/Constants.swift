//
//  Constants.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.03.2024.
//

import UIKit

enum Constants {
    
    // MARK: - Padding
    
    enum Padding {
        
    }
    
    // MARK: - PanModal
    
    enum PanModal {
        static let short = UIScreen.main.bounds.height * 0.15
        static let long = UIScreen.main.bounds.height * 0.6
        static let cornerRadius: CGFloat = 20
    }
    
    enum NotificationNameConstants: String {
        case theme
        
        var name: Notification.Name {
            return Notification.Name(self.rawValue)
        }
    }
}
