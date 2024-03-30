//
//  ProfileDetailCellViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import Foundation

protocol IProfileDetailCellViewModel {
    var title: String { get }
    var value: String { get }
    var isEditable: Bool { get }
    var isLast: Bool { get }
}

final class ProfileDetailCellViewModel {
    
    // MARK: - Properties
    
    let detail: ProfileDetail
    
    // MARK: - Object Lifecycle
    
    init(details: ProfileDetail) {
        self.detail = details
    }
}

extension ProfileDetailCellViewModel: IProfileDetailCellViewModel {
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
