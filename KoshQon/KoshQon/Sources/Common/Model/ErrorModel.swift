//
//  ErrorModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 18.05.2024.
//

import Foundation

struct ErrorModel:Error, Codable {
    var message: String?
    var errorCode: Int?
    var code: Int?
}
