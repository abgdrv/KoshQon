//
//  GenderOption.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 20.03.2024.
//

import Foundation

enum Gender: String, CaseIterable {
    case none = "gender.none"
    case male = "male"
    case female = "female"
    
    var title: String {
        self.rawValue
    }
}