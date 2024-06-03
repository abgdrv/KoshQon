//
//  EditProfileViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import Foundation

final class EditProfileViewModel {
    
    // MARK: - Properties
        
    var items: [ProfileDetailCellViewModel] = []
    private let detailTypes = ProfileDetailType.allCases
    private var details: [ProfileDetail] = []
        
    // MARK: - Object Lifecycle
    
    init() {
        getDetails()
        getProfileDetailsCellViewModels()
    }
}

extension EditProfileViewModel {
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
            let characteristics: [CharacteristicType] = AppData.shared.user.chars
            switch type {
            case .name:
                detail = .init(type: type, value: [AppData.shared.user.fullName])
            case .birthday:
                detail = .init(type: type, value: [AppData.shared.user.birthdayString])
            case .gender:
                detail = .init(type: type, value: [AppData.shared.user.gender.title])
            case .phone:
                detail = .init(type: type, value: [AppData.shared.user.phoneNumber])
            case .country:
                detail = .init(type: type, value: [AppData.shared.user.country.countryTitle])
            case .city:
                detail = .init(type: type, value: [AppData.shared.user.city.name])
            case .characteristics:
                detail = .init(type: type, value: characteristics.map { $0.rawValue } )
            case .about:
                detail = .init(type: type, value: [AppData.shared.user.about])
            }
            details.append(detail)
        }
        self.details = details
    }
}
