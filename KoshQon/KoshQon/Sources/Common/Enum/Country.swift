//
//  Country.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 20.03.2024.
//

import Foundation

enum Country: String, CaseIterable {
    case kz = "Kazakhstan"
    case ru = "Russia"
    case tj = "Tajikistan"
    case uz = "Uzbekistan"
    case az = "Azerbaijan"
    case am = "Armenia"
    case by = "Belarus"
    case kg = "Kyrgyzstan"
    case md = "Moldova"
    case tm = "Turkmenistan"
    
    var fullTitle: String {
        flag + " " + phoneCode + " " + title
    }
    
    var phoneCodeTitle: String {
        flag + " " + phoneCode
    }
    
    var countryTitle: String {
        flag + " " + title
    }
    
    var flag: String {
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
    
    var title: String {
        self.rawValue
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
    
    var cities: [String] {
        switch self {
        case .kz:
            ["Aktau", "Aktobe", "Almaty", "Astana", "Arkalyk", "Atyrau", "Baikonur", "Balqash", "Jezkazgan",
             "Karaganda", "Kentau", "Kyzylorda", "Kokshetau", "Kostanay", "Janaozen", "Pavlodar", "Petropavl",
             "Ridder", "Saran", "Satpayev", "Semey", "Stepnogorsk", "Taldykorgan", "Taraz", "Temirtau",
             "Turkistan", "Oral", "Oskemen", "Shymkent", "Shakhtinsk", "Schuchinsk", "Ekibastuz"]
        case .ru:
            []
        default:
            []
        }
    }
}
