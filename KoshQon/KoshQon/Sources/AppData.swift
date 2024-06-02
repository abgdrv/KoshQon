//
//  AppData.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 02.06.2024.
//

import Foundation

final class AppData {
    
    static let shared = AppData()
    
    var user: User?
    
    var announcements: [Announcement] = [
    ]
    
    private init() {}
    
}
