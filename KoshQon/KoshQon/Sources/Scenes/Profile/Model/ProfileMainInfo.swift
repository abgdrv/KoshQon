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
    private let country: String
    private let city: String
    let age: Int
    let friends: Int
    
    var fullName: String {
        secondName + " " + firstName
    }
    
    var location: String {
        city + ", " + country
    }
    
    init(firstName: String, secondName: String, country: String, city: String, age: Int, friends: Int) {
        self.firstName = firstName
        self.secondName = secondName
        self.country = country
        self.city = city
        self.age = age
        self.friends = friends
    }
}
