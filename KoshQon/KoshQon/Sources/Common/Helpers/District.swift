//
//  District.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 31.05.2024.
//

import Foundation

enum District: String, CaseIterable {
    case alatau = "alatau"
    case almaly = "almaly"
    case auez = "auez"
    case bostandyk = "bostandyk"
    case medeu = "medeu"
    case nauryzbay = "nauryzbay"
    case turksib = "turksib"
    case zhetysu = "zhetysu"
    
    var title: String {
        return rawValue.localized
    }
}
