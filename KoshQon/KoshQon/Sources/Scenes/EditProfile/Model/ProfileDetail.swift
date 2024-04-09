//
//  ProfileDetail.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import Foundation

struct ProfileDetail {
    let type: ProfileDetailType
    var value: [String]
    
    var title: String {
        switch type {
        case .name:
            "Полное Имя"
        case .birthday:
            "День рождения"
        case .gender:
            "Пол"
        case .phone:
            "Номер телефона"
        case .country:
            "Страна"
        case .city:
            "Город"
        case .characteristics:
            "Характеристики"
        case .about:
            "О себе"
        }
    }
    
    var isEditable: Bool {
        switch type {
        case .name:
            false
        default:
            true
        }
    }

}
