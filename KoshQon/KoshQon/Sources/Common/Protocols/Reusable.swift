//
//  Reusable.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 13.03.2024.
//

import Foundation

protocol Reusable: AnyObject {
    static var reuseID: String { get }
}

extension Reusable {
    
    static var reuseID: String {
        return String(describing: self)
    }
}
