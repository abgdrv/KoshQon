//
//  AppFontProtocol.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 18.02.2024.
//

import UIKit

protocol AppFontProtocol {
    var rawValue: String { get }
}

extension AppFontProtocol {
    
    private func apply(size value: CGFloat) -> UIFont {
        guard let font = UIFont.init(name: rawValue, size: value) else {
            print("Could not find font with name \(rawValue)")
            return .systemFont(ofSize: value)
        }
        return font
    }
    
}

extension AppFontProtocol {
    
    var s10: UIFont {
        return apply(size: 10)
    }
    
    var s12: UIFont {
        return apply(size: 12)
    }
    
    var s14: UIFont {
        return apply(size: 14)
    }
    
    var s16: UIFont {
        return apply(size: 16)
    }
    
    var s18: UIFont {
        return apply(size: 18)
    }
    
    var s20: UIFont {
        return apply(size: 20)
    }
    
    var s22: UIFont {
        return apply(size: 22)
    }
    
    var s24: UIFont {
        return apply(size: 24)
    }
    
    var s26: UIFont {
        return apply(size: 26)
    }
    
    var s28: UIFont {
        return apply(size: 28)
    }
    
    var s30: UIFont {
        return apply(size: 30)
    }
    
    var s32: UIFont {
        return apply(size: 32)
    }
    
    var s40: UIFont {
        return apply(size: 40)
    }
    
    var s64: UIFont {
        return apply(size: 64)
    }

}
