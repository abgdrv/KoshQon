//
//  City.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.04.2024.
//

import Foundation

enum City: String, CaseIterable {
    case almaty = "727"
    case astana = "7172"
    case shymkent = "7252"
    case aktau = "7292"
    case aktobe = "7132"
    case atyrau = "7122"
    case karaganda = "7212"
    case kokshetau = "7162"
    case kostanay = "7142"
    case pavlodar = "7182"
    case petropavlovsk = "7152"
    case taldykorgan = "7282"
    case taraz = "7262"
    case uralsk = "7112"
    case ustKamenogorsk = "7232"
    case shakhtinsk = "7102"
    case ekibastuz = "7187"
    case temirtau = "72132"
    
    var name: String {
        switch self {
        case .almaty:
            "city.almaty"
        case .astana:
            "city.astana"
        case .shymkent:
            "city.shymkent"
        case .aktau:
            "city.aktau"
        case .aktobe:
            "city.aktobe"
        case .atyrau:
            "city.atyrau"
        case .karaganda:
            "city.karaganda"
        case .kokshetau:
            "city.kokshetau"
        case .kostanay:
            "city.kostanay"
        case .pavlodar:
            "city.pavlodar"
        case .petropavlovsk:
            "city.petropavlovsk"
        case .taldykorgan:
            "city.taldykorgan"
        case .taraz:
            "city.taraz"
        case .uralsk:
            "city.uralsk"
        case .ustKamenogorsk:
            "city.ust_kamenogorsk"
        case .shakhtinsk:
            "city.shakhtinsk"
        case .ekibastuz:
            "city.ekibastuz"
        case .temirtau:
            "city.temirtau"
        }
    }
}
