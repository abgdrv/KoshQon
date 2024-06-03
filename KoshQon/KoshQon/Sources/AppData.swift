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
            user: User(
                phoneNumber: "+77778554383",
                password: "",
                fname: "Егор",
                lname: "Бургов",
                about: "Привет, я Егор из Алматы. Работа - моя страсть. Люблю спорт и забочусь о домашних животных.",
                city: .almaty,
                birthday: "25.05.2002".toDate(format: "dd.MM.yyyy") ?? Date(),
                gender: .male,
                chars: [.job, .pet, .sport, .student],
                good: 7,
                responsible: 9,
                clean: 10
            ),
            
            images: [AppImage.Announcements.ann1_1.uiImage, AppImage.Announcements.ann1_2.uiImage, AppImage.Announcements.ann1_3.uiImage],
            type: ApartmentsType.flat.title,
            city: City.almaty.name,
            district: District.bostandyk.title,
            street: "Жандосова",
            houseNumber: "94",
            rooms: "2",
            area: "70",
            floor: ("6", "20"),
            sanuzel: Sanuzel.vmeste.title,
            condition: Condition.high.title,
            isInternet: true,
            description: "",
            date: "25.05.2024".toDate(format: "dd.MM.yyyy") ?? Date(),
            age: ("20", "25"),
            gender: Gender.male.title,
            budget: ("130000", "150000")
        ),
        
            .init(
                user: User(
                    phoneNumber: "+77058958218",
                    password: "",
                    fname: "Владислав",
                    lname: "Христенко",
                    about: "Студент, люблю готовить и уделяю время отдыху с друзьями, наслаждаясь кальяном.",
                    city: .almaty,
                    birthday: "25.05.2004".toDate(format: "dd.MM.yyyy") ?? Date(),
                    gender: .male,
                    chars: [.alcohol, .cook, .smoke, .student],
                    good: 9,
                    responsible: 7,
                    clean: 8
                ),
                
                images: [AppImage.Announcements.ann2_1.uiImage, AppImage.Announcements.ann2_2.uiImage, AppImage.Announcements.ann2_3.uiImage],
                type: ApartmentsType.flat.title,
                city: City.almaty.name,
                district: District.bostandyk.title,
                street: "Володарского",
                houseNumber: "40",
                rooms: "2",
                area: "72",
                floor: ("5", "10"),
                sanuzel: Sanuzel.vmeste.title,
                condition: Condition.high.title,
                isInternet: true,
                description: "По всем вопросам обращаться по номеру.",
                date: "22.05.2024".toDate(format: "dd.MM.yyyy") ?? Date(),
                age: ("18", "24"),
                gender: Gender.male.title,
                budget: ("190000", "210000")
            ),
        
            .init(
                user: User(
                    phoneNumber: "+77009740178",
                    password: "",
                    fname: "Нуржан",
                    lname: "Максатов",
                    about: "Привет, я Нуржан из Алматы. С детства увлекаюсь готовкой - мое хобби и страсть. Обожаю экспериментировать с рецептами и радовать близких вкусными блюдами.",
                    city: .almaty,
                    birthday: "25.05.2000".toDate(format: "dd.MM.yyyy") ?? Date(),
                    gender: .male,
                    chars: [.religion, .cook, .sport, .student, .job],
                    good: 9,
                    responsible: 7,
                    clean: 8
                ),
                
                images: [AppImage.Announcements.ann3_1.uiImage, AppImage.Announcements.ann3_2.uiImage],
                type: ApartmentsType.flat.title,
                city: City.almaty.name,
                district: District.bostandyk.title,
                street: "мкр Таугуль-1",
                houseNumber: "91",
                rooms: "1",
                area: "44",
                floor: ("7", "9"),
                sanuzel: Sanuzel.vmeste.title,
                condition: Condition.middle.title,
                isInternet: true,
                description: "По всем вопросам обращаться по номеру.",
                date: "18.05.2024".toDate(format: "dd.MM.yyyy") ?? Date(),
                age: ("18", "24"),
                gender: Gender.male.title,
                budget: ("140000", "150000")
            ),
        
    ]
    
    var favorites: [Announcement] = []
    
    var myAnnouncements: [Announcement] = []
    
    private init() {}
    
}
