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
        case .main(let mainType):
            switch mainType {
            case .search:
                return "Найти"
            case .myAnnouncements:
                return "Мои объявления"
            case .guide:
                return "Гид"
            }
        case .settings(let settingsType):
            switch settingsType {
            case .personal:
                return "Личная информация"
            case .privacy:
                return "Конфиденциальность"
            case .theme:
                return "Тема приложения"
            case .language:
                return "Язык"
            case .about:
                return "О приложении"
            case .quit:
                return "Выйти"
            }
        case .privacy(let privacyType):
            switch privacyType {
            case .deactivate:
                return "Деактивировать аккаунт"
            }
        case .theme(let themeType):
            switch themeType {
            case .light:
                return "Светлая"
            case .dark:
                return "Темная"
            case .system:
                return "Системная"
            }
        case .language(let languageType):
            switch languageType {
            case .kazakh:
                return "Казахский"
            case .russian:
                return "Русский"
            case .language:
                return "Английский"
            }
        case .more(let moreType):
            switch moreType {
            case .unfriend:
                return "Удалить из контактов"
            case .write:
                return "Написать"
            case .call:
                return "Позвонить"
            }
        }
    }
    
    var image: UIImage? {
        switch type {
        case .main(let mainType):
            switch mainType {
            case .search:
                return AppImage.Main.search.uiImage?.withTintColor(AppColor.Theme.mainTitle.uiColor)
            case .myAnnouncements:
                return AppImage.Main.announcement.uiImage?.withTintColor(AppColor.Theme.mainTitle.uiColor)
            case .guide:
                return AppImage.Main.guide.uiImage?.withTintColor(AppColor.Theme.mainTitle.uiColor)
            }
        case .settings(let settingsType):
            switch settingsType {
            case .personal:
                return AppImage.Settings.personal.uiImage?.withRenderingMode(.alwaysOriginal)
            case .privacy:
                return AppImage.Settings.privacy.uiImage?.withRenderingMode(.alwaysOriginal)
            case .theme:
                return AppImage.Settings.theme.uiImage?.withRenderingMode(.alwaysOriginal)
            case .language:
                return AppImage.Settings.language.uiImage?.withRenderingMode(.alwaysOriginal)
            case .about:
                return AppImage.Settings.about.uiImage?.withRenderingMode(.alwaysOriginal)
            case .quit:
                return AppImage.Settings.quit.uiImage?.withRenderingMode(.alwaysOriginal)
            }
        case .privacy(let privacyType):
            switch privacyType {
            case .deactivate:
                return AppImage.Settings.deactivate.uiImage?.withRenderingMode(.alwaysOriginal)
            }
        case .more(let moreType):
            switch moreType {
            case .unfriend:
                return AppImage.Settings.deactivate.uiImage?.withRenderingMode(.alwaysOriginal)
            case .write:
                return AppImage.Common.letter.uiImage?.withRenderingMode(.alwaysOriginal)
            case .call:
                return AppImage.Common.phone.uiImage?.withRenderingMode(.alwaysOriginal)
            }
        default:
            return nil
        }
    }
    
    var isLast: Bool {
        switch type {
        case .main(let mainType):
            switch mainType {
            case .guide:
                return true
            default:
                return false
            }
        default:
            return false
        }
    }
}
