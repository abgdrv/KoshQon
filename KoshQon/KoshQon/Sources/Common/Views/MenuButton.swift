//
//  MenuButton.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 20.03.2024.
//

import UIKit
import ContextMenuSwift

enum MenuType: String {
    case phone = "Код страны"
    case gender = "Пол"
    case country = "Страна"
    case city = "Город"
    
    var title: String {
        return self.rawValue
    }
}

final class MenuButton: UIButton {
    
    // MARK: - Properties
    
    var didSelect: Callback<String>?
    var didCountrySelect: VoidCallback?
    var didPhoneCodeSelect: Callback<String>?
    
    var menuType: MenuType? {
        didSet {
            setup()
        }
    }
        
    private var menuValues: [String] = []
    
    private static var country: Country = .kz
    private static var countries = Country.allCases
    private static var cities = City.allCases
    private static var genders = Gender.allCases
    
    private var menuItems: [ContextMenuItem] {
        var menuItems: [ContextMenuItem] = []
        switch menuType {
        case .phone:
            MenuButton.countries.forEach { country in
                menuItems.append(country.fullPhoneCodeTitle)
                menuValues.append(country.shortPhoneCodeTitle)
            }
        case .gender:
            MenuButton.genders.forEach { gender in
                menuItems.append(gender.title)
                menuValues.append(gender.title)
            }
        case .city:
            MenuButton.cities.forEach { city in
                menuItems.append(city.name)
                menuValues.append(city.name)
            }
        case .country:
            menuItems.append(MenuButton.country.countryTitle)
            menuValues.append(MenuButton.country.countryTitle)
        case .none:
            break
        }
        return menuItems
    }
    
    private var title: String {
        switch menuType {
        case .phone:
            MenuButton.country.shortPhoneCodeTitle
        default:
            ""
        }
    }
}

private extension MenuButton {
    func setup() {
        setTitle(title, for: .normal)
        set(font: AppFont.medium.s14, titleColor: AppColor.Static.darkGray.uiColor)
        addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        
        CM.MenuConstants.BlurEffectEnabled = false
        CM.MenuConstants.MenuCornerRadius = 8
        CM.MenuConstants.LabelDefaultFont = AppFont.medium.s16
        CM.MenuConstants.LabelDefaultColor = AppColor.Theme.mainTitle.uiColor
        CM.MenuConstants.MaxZoom = 0.95
        CM.MenuConstants.MinZoom = 1
        CM.MenuConstants.ItemDefaultColor = AppColor.Theme.menuBackground.uiColor
        CM.MenuConstants.ItemDefaultHeight = UIDevice.current.isSmall ? 40 : 44
        CM.MenuConstants.MenuMarginSpace = 0
    }
}

extension MenuButton: ContextMenuDelegate {
    func contextMenuDidSelect(_ contextMenu: ContextMenuSwift.ContextMenu,
                              cell: ContextMenuSwift.ContextMenuCell,
                              targetedView: UIView,
                              didSelect item: any ContextMenuSwift.ContextMenuItem,
                              forRowAt index: Int) -> Bool {
        switch menuType {
        case .phone:
            self.didPhoneCodeSelect?(menuValues[index])
            setTitle(menuValues[index], for: .normal)
        case .gender:
            self.didSelect?(menuValues[index])
        case .city:
            self.didSelect?(menuValues[index])
        case .country:
            self.didSelect?(menuValues[index])
            self.didCountrySelect?()
        case .none:
            break
        }
        return true
    }
    
    func contextMenuDidDeselect(_ contextMenu: ContextMenuSwift.ContextMenu, cell: ContextMenuSwift.ContextMenuCell, targetedView: UIView, didSelect item: any ContextMenuSwift.ContextMenuItem, forRowAt index: Int) {
    }
    
    func contextMenuDidAppear(_ contextMenu: ContextMenuSwift.ContextMenu) {
    }
    
    func contextMenuDidDisappear(_ contextMenu: ContextMenuSwift.ContextMenu) {
    }
}

private extension MenuButton {
    @objc func showMenu() {
        CM.items = menuItems
        CM.headerView = MenuHeaderView(menuType: menuType ?? .phone)
        CM.showMenu(viewTargeted: self, delegate: self, animated: true)
    }
}
