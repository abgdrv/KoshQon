//
//  SignInModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 21.02.2024.
//

import Foundation

struct SignInModel: Encodable {
    let phoneNumber: String
    let password: String
    
    var formattedPhoneNumber: String {
        phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted)
                                         .joined(separator: "")
    }
}
