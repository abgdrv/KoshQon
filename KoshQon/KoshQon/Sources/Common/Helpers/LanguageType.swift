//
//  LanguageType.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 27.05.2024.
//

import Foundation

enum LanguageType: String, Codable {
    case kz = "kk"
    case ru = "ru"
    case en = "en"
}

extension LanguageType {
    var serverLang: String {
        return self.rawValue
    }
    
    var locale: Locale {
        switch self {
        case .ru:
            return Locale(identifier: "ru_RU")
        case .en:
            return Locale(identifier: "en_US")
        case .kz:
            return Locale(identifier: "kk_KZ")
        }
    }
}
