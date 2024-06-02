//
//  Announcement.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 31.05.2024.
//

import UIKit

struct Announcement {
    let id: UUID = UUID()
    let user: User?
    var images: [UIImage] = []
    let type: String
    let city: String
    let district: String
    let street: String
    let houseNumber: String
    let rooms: String
    let area: String
    let floor: (String, String)
    let sanuzel: String
    let condition: String
    let isInternet: Bool
    let description: String
    let date: Date = Date()
    
    let age: (String, String)
    let gender: String
    let budget: (String, String)
    
    var title: String {
        return street + ", " + String(houseNumber)
    }
    
    var address: String {
        return city + ", " + district
    }
}
