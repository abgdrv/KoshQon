//
//  CharacteristicType.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import Foundation
import UIKit

enum CharacteristicType: String, CaseIterable {
    case good = "decency"
    case responsible = "responsibility"
    case clean = "clean"
    
    case smoke = "smoke"
    case alcohol = "alcohol"
    case sport = "sport"
    case pet = "pet"
    case job = "job"
    case student = "student"
    case cook = "cook"
    case religion = "religion"
    
    var title: String {
        return rawValue.localized
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

