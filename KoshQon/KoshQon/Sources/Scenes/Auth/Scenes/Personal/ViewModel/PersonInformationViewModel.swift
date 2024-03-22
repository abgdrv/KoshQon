//
//  PersonalViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 21.03.2024.
//

import Foundation

final class PersonalViewModel {
    
    
    func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }
    
}
