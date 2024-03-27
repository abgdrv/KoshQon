//
//  NavigationCellViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 12.03.2024.
//

import Foundation
import UIKit

protocol INavigationCellViewModel {
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

extension NavigationCellViewModel: INavigationCellViewModel {
    var title: String {
        switch type {
        case .search:
            "Найти"
        case .announcements:
            "Мои объявления"
        case .guide:
            "Гид"
        default:
            ""
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
        default:
            nil
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
