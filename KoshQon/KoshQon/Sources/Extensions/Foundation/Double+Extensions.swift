//
//  Double+Extensions.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.02.2024.
//

import Foundation

extension Double {
    
    var convertedToString: String {
        let doubleString = "\(self)"
        let double = Double(doubleString.replacingOccurrences(of: ",", with: ".")) ?? 0
        return String(format: "%.1f", double)
    }
    
}
