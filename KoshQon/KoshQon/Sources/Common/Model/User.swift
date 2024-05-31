//
//  User.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 31.05.2024.
//

import UIKit

struct User {
    let id: Int
    let phoneNumber: String
    var password: String
    var image: UIImage?
    let fname: String
    let lname: String
    var age: Int
    var about: String = ""
    let country: Country = .kz
    var city: City
    let date: Date
    let gender: Gender
    var chars: [CharacteristicType] = []
    
    var good: Int = 0
    var responsible: Int = 0
    var clean: Int = 0
    
    var rating: Double {
        return Double(good + responsible + clean) / 3
    }
}
