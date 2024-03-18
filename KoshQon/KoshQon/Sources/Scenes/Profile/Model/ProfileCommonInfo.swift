//
//  ProfileCommonInfo.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 15.03.2024.
//

import Foundation
import UIKit

struct ProfileCommonInfo {
    let rating: Float
    let good: Float
    let responsible: Float
    let clean: Float
    let characteristics: [CharacteristicType]
}

enum CharacteristicType: CaseIterable {
    case good
    case responsible
    case clean
    
    case smoke
    case alcohol
    case sport
    case pet
    case job
    case student
    case cook
    case religion
    
    var title: String {
        switch self {
        case .good:
            "Порядочность"
        case .responsible:
            "Ответственность"
        case .clean:
            "Чистоплотность"
        case .smoke:
            "Курение"
        case .alcohol:
            "Алкоголь"
        case .sport:
            "Спорт"
        case .pet:
            "Домашние животные"
        case .job:
            "Работа"
        case .student:
            "Студент"
        case .cook:
            "Кулинарные навыки"
        case .religion:
            "Религия"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .good:
            AppImage.Profile.good.uiImage
        case .responsible:
            AppImage.Profile.responsible.uiImage
        case .clean:
            AppImage.Profile.clean.uiImage
        case .smoke:
            AppImage.Profile.smoke.uiImage
        case .alcohol:
            AppImage.Profile.alcohol.uiImage
        case .sport:
            AppImage.Profile.sport.uiImage
        case .pet:
            AppImage.Profile.pet.uiImage
        case .job:
            AppImage.Profile.job.uiImage
        case .student:
            AppImage.Profile.student.uiImage
        case .cook:
            AppImage.Profile.cook.uiImage
        case .religion:
            AppImage.Profile.religion.uiImage
        }
    }
    
    var color: UIColor? {
        switch self {
        case .good:
            AppColor.Static.lightRed.uiColor
        case .responsible:
            AppColor.Static.green.uiColor
        case .clean:
            AppColor.Static.lightBlue.uiColor
        default:
            nil
        }
    }
}

