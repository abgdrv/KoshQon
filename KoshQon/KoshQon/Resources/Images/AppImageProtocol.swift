//
//  AppImageProtocol.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 18.02.2024.
//

import SwiftUI

protocol AppImageProtocol {
    var rawValue: String { get }
}

extension AppImageProtocol {
    
    var uiImage: UIImage? {
        guard let image = UIImage(named: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
    
    var systemImage: UIImage? {
        guard let image = UIImage(systemName: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
    
    var swiftUIImage: Image {
        guard let image = UIImage(named: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return Image(uiImage: image)
    }
    
}
