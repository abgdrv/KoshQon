//
//  AppData.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 02.06.2024.
//

import Foundation

final class AppData {
    
    static let shared = AppData()
    
    let mainUser = User(
        phoneNumber: "+77775817773",
        password: "",
        image: AppImage.Common.Almat.uiImage,
        fname: "Алмат",
        lname: "Бегайдаров",
        about: "Студент 4 курса КБТУ",
        city: .almaty,
        birthday: "23.03.2002".toDate(format: "dd.MM.yyyy") ?? Date(),
        gender: .male,
        chars: [.cook, .job, .student, .sport],
        good: 10,
        responsible: 10,
        clean: 9
    )
    
    var user: User = User(
        phoneNumber: "+77775817773",
        password: "",
        image: AppImage.Common.Almat.uiImage,
        fname: "Алмат",
        lname: "Бегайдаров",
        about: "Студент 4 курса КБТУ",
        city: .almaty,
        birthday: "23.03.2002".toDate(format: "dd.MM.yyyy") ?? Date(),
        gender: .male,
        chars: [.cook, .job, .student, .sport],
        good: 10,
        responsible: 10,
        clean: 9
    )
    
    var announcements: [Announcement] = [
        .init(
            user: User(phoneNumber: "", password: "", fname: "", lname: "", city: .aktau, birthday: Date(), gender: .male, good: 10),
            type: "sad", city: "sda", district: "sda", street: "dasd", houseNumber: "dsa", rooms: "asd", area: "sad", floor: ("", ""), sanuzel: "", condition: "", isInternet: false, description: "", age: ("", ""), gender: "", budget: ("", "")),
        .init(
            user: User(phoneNumber: "", password: "", fname: "", lname: "", city: .aktau, birthday: Date(), gender: .male),
            type: "sad", city: "sda", district: "sda", street: "dasd", houseNumber: "dsa", rooms: "asd", area: "sad", floor: ("", ""), sanuzel: "", condition: "", isInternet: false, description: "", age: ("", ""), gender: "", budget: ("", "")),
        .init(
            user: User(phoneNumber: "", password: "", fname: "", lname: "", city: .aktau, birthday: Date(), gender: .male),
            type: "sad", city: "sda", district: "sda", street: "dasd", houseNumber: "dsa", rooms: "asd", area: "sad", floor: ("", ""), sanuzel: "", condition: "", isInternet: false, description: "", age: ("", ""), gender: "", budget: ("", "")),
        .init(
            user: User(phoneNumber: "", password: "", fname: "", lname: "", city: .aktau, birthday: Date(), gender: .male),
            type: "sad", city: "sda", district: "sda", street: "dasd", houseNumber: "dsa", rooms: "asd", area: "sad", floor: ("", ""), sanuzel: "", condition: "", isInternet: false, description: "", age: ("", ""), gender: "", budget: ("", ""))
    ]
    
    var favorites: [Announcement] = []
    
    var myAnnouncements: [Announcement] = []
    
    private init() {}
    
}
