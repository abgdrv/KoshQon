//
//  ProfileViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 15.03.2024.
//

import Foundation

final class ProfileViewModel {
    
    // MARK: - Properties
    
    var items: [AdvertisementViewModel] = []
    
    let main = ProfileMainInfo(firstName: "Имя",
                               secondName: "Фамилия",
                               country: "Казахстан",
                               city: "Алматы",
                               age: 25,
                               friends: 50)
    
    let about = ProfileAboutInfo(text: "Я ответственный, проактивный, стрессоустойчивый, коммуникабельный, честный. Мои сильные стороны — хорошие управленческие и лидерские навыки, клиентоориентированность, системное мышление, позитивный настрой. Не пью, не курю, есть права категории «B».")
    
    let common = ProfileCommonInfo(rating: 6.2,
                                   good: 8.5,
                                   responsible: 6.2,
                                   clean: 3.8,
                                   characteristics: [.cook, .job, .student, .sport])
    
    let ads = [
        Advertisement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7),
        Advertisement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7),
        Advertisement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7),
        Advertisement(title: "Ищу сожителя", address: "Алматы, Бостандыкский район", date: "2 февраля", rating: 8.7)
    ]
    
    // MARK: - Object Lifecycle
    
    init() {
        getAdvertisements()
    }
    
    // MARK: - Private methods
    
    func makeCellViewModels(items: [Advertisement]) -> [AdvertisementViewModel] {
        return items.compactMap { AdvertisementViewModel(advertisement: $0) }
    }
}

// MARK: - Request

private extension ProfileViewModel {
    func getAdvertisements() {
        items = makeCellViewModels(items: ads)
    }
}
