//
//  City.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.04.2024.
//

import Foundation

enum City: String, CaseIterable {
    case almaty = "almaty"
    case astana = "astana"
    case shymkent = "shymkent"
    case aktau = "aktau"
    case aktobe = "aktobe"
    case atyrau = "atyrau"
    case karaganda = "karaganda"
    case kokshetau = "kokshetau"
    case kostanay = "kostanay"
    case pavlodar = "pavlodar"
    case petropavlovsk = "petropavlovsk"
    case taldykorgan = "taldykorgan"
    case taraz = "taraz"
    case uralsk = "uralsk"
    case ustKamenogorsk = "ust_kamenogorsk"
    case shakhtinsk = "shakhtinsk"
    case ekibastuz = "ekibastuz"
    case temirtau = "temirtau"
    
    var name: String {
        return rawValue.localized
    }
    
    var code: String {
        switch self {
        case .almaty:
            "727"
        case .astana:
            "7172"
        case .shymkent:
            "7252"
        case .aktau:
            "7292"
        case .aktobe:
            "7132"
        case .atyrau:
            "7122"
        case .karaganda:
            "7212"
        case .kokshetau:
            "7162"
        case .kostanay:
            "7142"
        case .pavlodar:
            "7182"
        case .petropavlovsk:
            "7152"
        case .taldykorgan:
            "7282"
        case .taraz:
            "7262"
        case .uralsk:
            "7112"
        case .ustKamenogorsk:
            "7232"
        case .shakhtinsk:
            "7102"
        case .ekibastuz:
            "7187"
        case .temirtau:
            "72132"
        }
    }
}
