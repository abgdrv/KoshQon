//
//  Date+Extensions.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import Foundation

extension Date {
    
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
}
