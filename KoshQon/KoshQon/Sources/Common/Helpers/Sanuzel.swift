//
//  Sanuzel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 31.05.2024.
//

import Foundation

enum Sanuzel: String, CaseIterable {
    case vmeste = "sanuzel_vmeste"
    case otdelno = "sanuzel_otdelno"
    
    var title: String {
        return rawValue.localized
    }
}
