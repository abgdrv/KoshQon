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
        .init(user: nil, type: "sad", city: "sda", district: "sda", street: "dasd", houseNumber: "dsa", rooms: "asd", area: "sad", floor: ("", ""), sanuzel: "", condition: "", isInternet: false, description: "", age: ("", ""), gender: "", budget: ("", "")),
        .init(user: nil, type: "sad", city: "sda", district: "sda", street: "dasd", houseNumber: "dsa", rooms: "asd", area: "sad", floor: ("", ""), sanuzel: "", condition: "", isInternet: false, description: "", age: ("", ""), gender: "", budget: ("", "")),
        .init(user: nil, type: "sad", city: "sda", district: "sda", street: "dasd", houseNumber: "dsa", rooms: "asd", area: "sad", floor: ("", ""), sanuzel: "", condition: "", isInternet: false, description: "", age: ("", ""), gender: "", budget: ("", "")),
        .init(user: nil, type: "sad", city: "sda", district: "sda", street: "dasd", houseNumber: "dsa", rooms: "asd", area: "sad", floor: ("", ""), sanuzel: "", condition: "", isInternet: false, description: "", age: ("", ""), gender: "", budget: ("", "")),
        .init(user: nil, type: "sad", city: "sda", district: "sda", street: "dasd", houseNumber: "dsa", rooms: "asd", area: "sad", floor: ("", ""), sanuzel: "", condition: "", isInternet: false, description: "", age: ("", ""), gender: "", budget: ("", ""))
    ]
    
    private init() {}
    
}
