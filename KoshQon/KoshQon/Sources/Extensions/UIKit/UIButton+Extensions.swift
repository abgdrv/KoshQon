//
//  UIButton+Extensions.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.03.2024.
//

import Foundation
import UIKit

extension UIButton {
    
    func set(font: UIFont, titleColor: UIColor) {
        titleLabel?.font = font
        setTitleColor(titleColor, for: .normal)
    }
    
}
