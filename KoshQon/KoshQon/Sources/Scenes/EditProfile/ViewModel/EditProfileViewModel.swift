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
    
    var items: [ProfileDetailsCellViewModel] = []
    lazy var details: [ProfileDetails] = [
        .init(title: "Имя", value: profile.mainInfo.fullName, isEditable: false),
        .init(title: "День рождения", value: profile.mainInfo.birthdayString, isEditable: true),
        .init(title: "Номер телефона", value: profile.mainInfo.phoneNumber, isEditable: true),
//        .init(title: String, value: <#T##String#>, isEditable: <#T##Bool#>)
    ]
        
    // MARK: - Object Lifecycle
    
    init(profile: Profile) {
        self.profile = profile
        getProfileDetailsCellViewModels()
    }
}

private extension EditProfileViewModel {
    func getProfileDetailsCellViewModels() {
        items = makeCellViewModels(items: details)
    }
    
    func makeCellViewModels(items: [ProfileDetails]) -> [ProfileDetailsCellViewModel] {
        return items.compactMap { ProfileDetailsCellViewModel(details: $0) }
    }
}
