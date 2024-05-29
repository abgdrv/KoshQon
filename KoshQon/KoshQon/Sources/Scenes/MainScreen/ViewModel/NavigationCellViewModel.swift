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
                return LocalizableKeys.NavigationCell.find.localized()
            case .myAnnouncements:
                return LocalizableKeys.NavigationBar.myAnnouncements.localized()
            case .guide:
                return LocalizableKeys.NavigationCell.guide.localized()
            }
        case .settings(let settingsType):
            switch settingsType {
            case .personal:
                return LocalizableKeys.NavigationBar.personalInfo.localized()
            case .privacy:
                return LocalizableKeys.NavigationBar.confidentiality.localized()
            case .theme:
                return LocalizableKeys.NavigationBar.appTheme.localized()
            case .language:
                return LocalizableKeys.NavigationBar.language.localized()
            case .about:
                return LocalizableKeys.NavigationCell.aboutApp.localized()
            case .quit:
                return LocalizableKeys.NavigationCell.quit.localized()
            }
        case .privacy(let privacyType):
            switch privacyType {
            case .deactivate:
                return LocalizableKeys.NavigationCell.deactivateAccount.localized()
            }
        case .theme(let themeType):
            switch themeType {
            case .light:
                return LocalizableKeys.NavigationCell.themeLight.localized()
            case .dark:
                return LocalizableKeys.NavigationCell.themeDark.localized()
            case .system:
                return LocalizableKeys.NavigationCell.themeSystem.localized()
            }
        case .language(let languageType):
            switch languageType {
            case .kazakh:
                return LocalizableKeys.NavigationCell.kz.localized()
            case .russian:
                return LocalizableKeys.NavigationCell.ru.localized()
            case .english:
                return LocalizableKeys.NavigationCell.en.localized()
            }
        case .more(let moreType):
            switch moreType {
            case .unfriend:
                return LocalizableKeys.NavigationCell.removeConnection.localized()
            case .write:
                return LocalizableKeys.ActionButton.write.localized()
            case .call:
                return LocalizableKeys.ActionButton.call.localized()
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
