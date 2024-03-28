//
//  ProfileDetailsCellViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import Foundation

protocol IProfileDetailsCellViewModel {
    var title: String { get }
    var value: String { get }
    var isEditable: Bool { get }
}

final class ProfileDetailsCellViewModel {
    
    // MARK: - Properties
    
    private let details: ProfileDetails
    
    // MARK: - Object Lifecycle
    
    init(details: ProfileDetails) {
        self.details = details
    }
}

extension ProfileDetailsCellViewModel: IProfileDetailsCellViewModel {
    var title: String {
        return details.title
    }
    
    var value: String {
        return details.value
    }
    
    var isEditable: Bool {
        return details.isEditable
    }
}
