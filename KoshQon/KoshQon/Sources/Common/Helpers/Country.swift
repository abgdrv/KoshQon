//
//  Country.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 20.03.2024.
//

import Foundation

enum Country: String, CaseIterable {
    case kz = "kazakhstan"
    case ru = "russia"
    case tj = "tajikistan"
    case uz = "uzbekistan"
    case az = "azerbaijan"
    case am = "armenia"
    case by = "belarus"
    case kg = "kyrgyzstan"
    case md = "moldova"
    case tm = "turkmenistan"
    
    var title: String {
        return rawValue.localized
    }
    
    var fullPhoneCodeTitle: String {
        flag + " " + phoneCode + " " + title
    }
    
    var shortPhoneCodeTitle: String {
        flag + " " + phoneCode
    }
    
    var countryTitle: String {
        flag + " " + title
    }
    
    private var flag: String {
        switch self {
        case .kz:
            "🇰🇿"
        case .ru:
            "🇷🇺"
        case .tj:
            "🇹🇯"
        case .uz:
            "🇺🇿"
        case .az:
            "🇦🇿"
        case .am:
            "🇦🇲"
        case .by:
            "🇧🇾"
        case .kg:
            "🇰🇬"
        case .md:
            "🇲🇩"
        case .tm:
            "🇹🇲"
        }
    }
    
    var phoneCode: String {
        switch self {
        case .kz:
            "+7"
        case .ru:
            "+7"
        case .tj:
            "+992"
        case .uz:
            "+998"
        case .az:
            "+994"
        case .am:
            "+374"
        case .by:
            "+375"
        case .kg:
            "+996"
        case .md:
            "+373"
        case .tm:
            "+993"
        }
    }
}
