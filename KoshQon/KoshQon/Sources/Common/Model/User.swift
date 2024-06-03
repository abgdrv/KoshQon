//
//  User.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 31.05.2024.
//

import SwiftUI

struct User {
    let id: UUID = UUID()
    var phoneNumber: String
    var password: String
    var image: UIImage? = AppImage.Personal.defaultProfile.uiImage
    var fname: String
    var lname: String
    var about: String = ""
    var country: Country = .kz
    var city: City
    var birthday: Date
    var gender: Gender
    var chars: [CharacteristicType] = []
    
    var good: Int = 0
    var responsible: Int = 0
    var clean: Int = 0
    
    var rating: Double {
        return Double(good + responsible + clean) / 3
    }
    
    var defaultImage: Image = AppImage.Personal.defaultProfile.swiftUIImage
    
    var fullName: String {
        fname + " " + lname
    }
    
    var address: String {
        city.name + ", " + country.title
    }
    
    var birthdayString: String {
        return birthday.toString(format: "dd.MM.yyyy")
    }
    
    var age: Int {
        return birthday.age()
    }
    
    var announcements: [Announcement] = []
}
