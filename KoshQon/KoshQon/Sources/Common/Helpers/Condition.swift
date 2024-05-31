//
//  Condition.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 31.05.2024.
//

import Foundation

enum Condition: String, CaseIterable {
    case high = "condition_high"
    case middle = "condition_middle"
    case low = "condition_low"
    
    var title: String {
        return rawValue.localized
    }
}
