//
//  MenuButton.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 20.03.2024.
//

import UIKit
import ContextMenuSwift

enum MenuType: String {
    case phone = "country_code"
    case gender = "gender"
    case country = "country"
    case city = "city"
    case district = "district"
    case condition = "condition"
    case apartmentType = "apartment_type"
    case sanuzel = "sanuzel"
    
    var title: String {
        return rawValue.localized
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
    private static var districts = District.allCases
    private static var conditions = Condition.allCases
    private static var apartmentTypes = ApartmentsType.allCases
    private static var sanuzelTypes = Sanuzel.allCases
    
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
        case .district:
            MenuButton.districts.forEach { district in
                menuItems.append(district.title)
                menuValues.append(district.title)
            }
        case .condition:
            MenuButton.conditions.forEach { condition in
                menuItems.append(condition.title)
                menuValues.append(condition.title)
            }
        case .apartmentType:
            MenuButton.apartmentTypes.forEach { type in
                menuItems.append(type.title)
                menuValues.append(type.title)
            }
        case .sanuzel:
            MenuButton.sanuzelTypes.forEach { type in
                menuItems.append(type.title)
                menuValues.append(type.title)
            }
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
            didPhoneCodeSelect?(menuValues[index])
            setTitle(menuValues[index], for: .normal)
        case .country:
            didSelect?(menuValues[index])
            didCountrySelect?()
        default:
            didSelect?(menuValues[index])
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
