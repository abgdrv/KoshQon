//
//  ProfileMainInfo.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 15.03.2024.
//

import Foundation

struct ProfileMainInfo {
    private let firstName: String
    private let lastName: String
    let country: Country
    let city: City
    private let birthday: Date
    
    let gender: Gender
    
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
        return lastName + " " + firstName
    }
    
    var location: String {
        return city.name + ", " + country.title
    }
    
    init(firstName: String, lastName: String, gender: Gender, country: Country, city: City, birthday: Date, friends: Int, phoneNumber: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.country = country
        self.city = city
        self.birthday = birthday
        self.friends = friends
        self.phoneNumber = phoneNumber
    }
}
