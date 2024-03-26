//
//  MainNavigationCellViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 12.03.2024.
//

import Foundation
import UIKit

enum MainNavigationType: CaseIterable {
    case search
    case announcements
    case guide
}

protocol IMainNavigationItemViewModel {
    var title: String { get }
    var image: UIImage? { get }
    var isLast: Bool { get }
}

final class MainNavigationCellViewModel {
    let type: MainNavigationType
    
    init(type: MainNavigationType) {
        self.type = type
    }
}

extension MainNavigationCellViewModel: IMainNavigationItemViewModel {
    var title: String {
        switch type {
        case .search:
            "Найти"
        case .announcements:
            "Мои объявления"
        case .guide:
            "Гид"
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
