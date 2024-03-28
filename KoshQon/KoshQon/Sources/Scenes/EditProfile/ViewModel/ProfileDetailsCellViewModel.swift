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
    var isLast: Bool { get }
}

final class ProfileDetailsCellViewModel {
    
    // MARK: - Properties
    
    private let detail: ProfileDetail
    
    // MARK: - Object Lifecycle
    
    init(details: ProfileDetail) {
        self.detail = details
    }
}

extension ProfileDetailsCellViewModel: IProfileDetailsCellViewModel {
    var title: String {
        return detail.title
    }
    
    var value: String {
        return detail.value
    }
    
    var isEditable: Bool {
        return detail.isEditable
    }
    
    var isLast: Bool {
        switch detail.type {
        case .about:
            true
        default:
            false
        }
    }
}
