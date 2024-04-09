//
//  EditProfileViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import Foundation

final class EditProfileViewModel {
    
    // MARK: - Properties
    
    private let profile: Profile
    
    var items: [ProfileDetailCellViewModel] = []
    private let detailTypes = ProfileDetailType.allCases
    private var details: [ProfileDetail] = []
        
    // MARK: - Object Lifecycle
    
    init(profile: Profile) {
        self.profile = profile
        getDetails()
        getProfileDetailsCellViewModels()
    }
}

private extension EditProfileViewModel {
    func getProfileDetailsCellViewModels() {
        items = makeCellViewModels(items: details)
    }
    
    func makeCellViewModels(items: [ProfileDetail]) -> [ProfileDetailCellViewModel] {
        return items.compactMap { ProfileDetailCellViewModel(details: $0) }
    }
    
    func getDetails() {
        var details: [ProfileDetail] = []
        detailTypes.forEach { type in
            let detail: ProfileDetail
            var characteristics: [CharacteristicType] = [.cook, .job, .student, .sport]
            switch type {
            case .name:
                detail = .init(type: type, value: [profile.mainInfo.fullName])
            case .birthday:
                detail = .init(type: type, value: [profile.mainInfo.birthdayString])
            case .gender:
                detail = .init(type: type, value: [profile.mainInfo.gender.title])
            case .phone:
                detail = .init(type: type, value: [profile.mainInfo.phoneNumber])
            case .country:
                detail = .init(type: type, value: [profile.mainInfo.country.title])
            case .city:
                detail = .init(type: type, value: [profile.mainInfo.city.name])
            case .characteristics:
                detail = .init(type: type, value: characteristics.map { $0.rawValue } )
            case .about:
                detail = .init(type: type, value: ["Я - ChatGPT, модель искусственного интеллекта от OpenAI. Готов помочь с вопросами, текстами, программированием и многим другим."])
            }
            details.append(detail)
        }
        self.details = details
    }
}
