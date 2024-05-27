//
//  AppColorProtocol.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 17.02.2024.
//

import SwiftUI

protocol AppColorProtocol {
    var rawValue: String { get }
}

extension AppColorProtocol {
    var uiColor: UIColor {
        guard let color = UIColor.init(named: rawValue) else {
            fatalError("Could not find color with name \(rawValue)")
        }
        return color
    }
    
    var cgColor: CGColor {
        return uiColor.cgColor
    }
    
    var swiftUIColor: Color {
        return Color(uiColor: uiColor)
    }
}
