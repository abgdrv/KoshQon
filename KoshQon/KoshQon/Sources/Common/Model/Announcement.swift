//
//  Announcement.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 31.05.2024.
//

import UIKit

struct Announcement {
    let userId: Int
    var images: [UIImage] = []
    let city: City
    let district: District
    let street: String
    let houseNumber: Int
    let rooms: Int
    let area: Int
    let floor: (Int, Int)
    let sanuzel: Sanuzel
    let condition: Condition
    let isInternet: Bool
    let description: String
    let date: Date
    
    let age: (Int, Int)
    let gender: Gender
    let budget: (Int, Int)
    
    var title: String {
        return street + ", " + String(houseNumber)
    }
    
    var address: String {
        return city.name + ", " + street
    }
}
