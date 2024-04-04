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
        case .myAnnouncements:
            "Мои объявления"
        case .guide:
            "Гид"
        case .personal:
            "Личная информация"
        case .privacy:
            "Конфиденциальность"
        case .theme:
            "Тема приложения"
        case .language:
            "Язык"
        case .about:
            "О приложении"
        case .quit:
            "Выйти"
        case .deactivate:
            "Деактивировать аккаунт"
        case .themeLight:
            "Светлая"
        case .themeDark:
            "Темная"
        case .themeDefault:
            "Системная"
        case .languageKazakh:
            "Казахский"
        case .languageRussian:
            "Русский"
        case .languageEnglish:
            "Английский"
        }
    }
    
    var image: UIImage? {
        switch type {
        case .search:
            AppImage.Main.search.uiImage?.withTintColor(AppColor.Theme.mainTitle.uiColor)
        case .myAnnouncements:
            AppImage.Main.announcement.uiImage?.withTintColor(AppColor.Theme.mainTitle.uiColor)
        case .guide:
            AppImage.Main.guide.uiImage?.withTintColor(AppColor.Theme.mainTitle.uiColor)
        case .personal:
            AppImage.Settings.personal.uiImage?.withRenderingMode(.alwaysOriginal)
        case .privacy:
            AppImage.Settings.privacy.uiImage?.withRenderingMode(.alwaysOriginal)
        case .theme:
            AppImage.Settings.theme.uiImage?.withRenderingMode(.alwaysOriginal)
        case .language:
            AppImage.Settings.language.uiImage?.withRenderingMode(.alwaysOriginal)
        case .about:
            AppImage.Settings.about.uiImage?.withRenderingMode(.alwaysOriginal)
        case .quit:
            AppImage.Settings.quit.uiImage?.withRenderingMode(.alwaysOriginal)
        case .deactivate:
            AppImage.Settings.deactivate.uiImage?.withRenderingMode(.alwaysOriginal)
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
