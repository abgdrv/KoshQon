//
//  Int+Extensions.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.05.2024.
//

import Foundation

extension Int {
    
    var age: String {
        let pluralString: String
        
        switch self % 10 {
        case 1:
            pluralString = "\(self) \(LocalizableKeys.Plural.yearSingular.localized())"
        case 2...4:
            pluralString = "\(self) \(LocalizableKeys.Plural.yearPlural.localized())"
        default:
            pluralString = "\(self) \(LocalizableKeys.Plural.yearsPlural.localized())"
        }
        
        return pluralString
    }
    
}
