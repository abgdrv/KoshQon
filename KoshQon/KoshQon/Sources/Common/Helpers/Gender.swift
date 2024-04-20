//
//  GenderOption.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 20.03.2024.
//

import Foundation

enum Gender: String, CaseIterable {
    case male = "gender.male"
    case female = "gender.female"
    
    var title: String {
        switch self {
        case .male:
            "Мужской"
        case .female:
            "Женский"
        }
    }
}
