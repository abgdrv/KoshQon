//
//  NavigationCellViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 12.03.2024.
//

import Foundation
import UIKit

protocol IMainNavigationItemViewModel {
    var title: String { get }
    var image: UIImage? { get }
    var isLast: Bool { get }
}

final class NavigationCellViewModel {
    let type: NavigationCellType
    
    init(type: NavigationCellType) {
        self.type = type
    }
}

extension NavigationCellViewModel: IMainNavigationItemViewModel {
    var title: String {
        switch type {
        case .search:
            "Найти"
        case .announcements:
            "Мои объявления"
        case .guide:
            "Гид"
        case .personal:
            <#code#>
        case .privacy:
            <#code#>
        case .theme:
            <#code#>
        case .language:
            <#code#>
        case .about:
            <#code#>
        case .quit:
            <#code#>
        }
    }
    
    var image: UIImage? {
        switch type {
        case .search:
            AppImage.Main.search.uiImage?.withTintColor(AppColor.Theme.mainTitle.uiColor)
        case .announcements:
            AppImage.Main.announcement.uiImage?.withTintColor(AppColor.Theme.mainTitle.uiColor)
        case .guide:
            AppImage.Main.guide.uiImage?.withTintColor(AppColor.Theme.mainTitle.uiColor)
        case .personal:
            <#code#>
        case .privacy:
            <#code#>
        case .theme:
            <#code#>
        case .language:
            <#code#>
        case .about:
            <#code#>
        case .quit:
            <#code#>
        }
    }
    
    var isLast: Bool {
        switch type {
        case .guide:
            true
        default:
            false
        }
    }
}
