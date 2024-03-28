//
//  ProfileMainInfo.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 15.03.2024.
//

import Foundation

struct ProfileMainInfo {
    private let firstName: String
    private let secondName: String
    private let country: Country
    private let city: String
    private let birthday: Date
    
    var birthdayString: String {
        return birthday.toString(format: "dd.MM.yyyy")
    }
    
    var age: Int {
        let now = Date()
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let age = ageComponents.year ?? 0
        return age
    }
    
    let friends: Int
    
    let phoneNumber: String
    
    var fullName: String {
        return secondName + " " + firstName
    }
    
    var location: String {
        return city + ", " + country.title
    }
    
    init(firstName: String, secondName: String, country: Country, city: String, birthday: Date, friends: Int, phoneNumber: String) {
        self.firstName = firstName
        self.secondName = secondName
        self.country = country
        self.city = city
        self.birthday = birthday
        self.friends = friends
        self.phoneNumber = phoneNumber
    }
}
