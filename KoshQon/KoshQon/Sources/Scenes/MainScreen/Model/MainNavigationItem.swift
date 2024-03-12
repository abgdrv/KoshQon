//
//  MainNavigationItem.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 10.03.2024.
//

import Foundation
import UIKit

enum MainNavigationType {
    case search
    case advertisements
    case guide
}

struct MainNavigationItem {
    let type: MainNavigationType
    
    var title: String {
        switch type {
        case .search:
            "Найти"
        case .advertisements:
            "Мои объявления"
        case .guide:
            "Гид"
        }
    }
    
    var image: UIImage? {
        switch type {
        case .search:
            AppImage.Main.search.uiImage
        case .advertisements:
            AppImage.Main.advertisement.uiImage
        case .guide:
            AppImage.Main.guide.uiImage
        }
    }
}
