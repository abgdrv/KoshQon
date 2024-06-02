//
//  ApartmentsType.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.06.2024.
//

import Foundation

enum ApartmentsType: String, CaseIterable {
    case flat = "flat"
    case house = "house"
    
    var title: String {
        return rawValue.localized
    }
}
