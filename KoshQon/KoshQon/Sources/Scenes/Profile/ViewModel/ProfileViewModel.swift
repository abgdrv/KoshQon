//
//  ProfileViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 15.03.2024.
//

import Foundation

final class ProfileViewModel {
    
    // MARK: - Properties
    
    var items: [AnnouncementViewModel] = []
    
    var profile: Profile?
    
    private let main = ProfileMainInfo(firstName: "Алмат",
                                       secondName: "Бегайдаров", gender: .male,
                                       country: Country.kz,
                                       city: City.kostanay,
                                       birthday: "23.03.2002".toDate(format: "dd.MM.yyyy") ?? Date(),
                                       friends: 50,
                                       phoneNumber: "+77775817773")
    
    private let about = ProfileAboutInfo(text: "Я - ChatGPT, модель искусственного интеллекта от OpenAI. Готов помочь с вопросами, текстами, программированием и многим другим.")
    
    private let common = ProfileCommonInfo(rating: 6.2,
                                           good: 8.5,
                                           responsible: 6.2,
                                           clean: 3.8,
                                           characteristics: [.cook, .job, .student, .sport])
    
    private let ads = [
        Announcement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7),
        Announcement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7),
        Announcement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7),
        Announcement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7)
    ]
    
    // MARK: - Object Lifecycle
    
    init() {
        getAnnouncements()
        getProfile()
    }
}

// MARK: - Private methods

private extension ProfileViewModel {
    func getAnnouncements() {
        items = makeCellViewModels(items: ads)
    }
    
    func makeCellViewModels(items: [Announcement]) -> [AnnouncementViewModel] {
        return items.compactMap { AnnouncementViewModel(announcement: $0, isProfile: true) }
    }
    
    func makeProfile() -> Profile {
        return Profile(mainInfo: main, aboutInfo: about, commonInfo: common)
    }
    
    func getProfile() {
        profile = makeProfile()
    }
}
