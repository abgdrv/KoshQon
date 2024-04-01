//
//  MenuButton.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 20.03.2024.
//

import UIKit

enum MenuType {
    case phone
    case gender
    case country
    case city
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
    
    private static var country: Country = .kz
    private static var countries = Country.allCases
    private static var cities = City.allCases
    private static var genders = Gender.allCases
    
    private var menuItems: [UIAction] {
        var menuItems: [UIAction] = []
        switch menuType {
        case .phone:
            MenuButton.countries.forEach { country in
                menuItems.append(UIAction(title: country.fullPhoneCodeTitle, handler: { action in
                    self.setTitle(country.shortPhoneCodeTitle, for: .normal)
                    self.didPhoneCodeSelect?(country.phoneCode)
                }))
            }
        case .gender:
            MenuButton.genders.forEach { gender in
                menuItems.append(UIAction(title: gender.title, handler: { action in
                    self.didSelect?(gender.title)
                }))
            }
        case .city:
            MenuButton.cities.forEach { city in
                menuItems.append(UIAction(title: city.name, handler: { action in
                    self.didSelect?(city.name)
                }))
            }
        case .country:
            menuItems.append(UIAction(title: MenuButton.country.countryTitle, handler: { action in
                self.didSelect?(MenuButton.country.title)
                self.didCountrySelect?()
            }))
        case .none:
            break
        }
        return menuItems
    }
    
    private var menuTitle: String {
        switch menuType {
        case .phone:
            "Код страны"
        case .gender:
            "Пол"
        case .country:
            "Страна"
        case .city:
            "Город"
        case .none:
            ""
        }
    }
    
    private var title: String {
        switch menuType {
        case .phone:
            Country.kz.shortPhoneCodeTitle
        default:
            ""
        }
    }
    
    private var font: UIFont {
        switch menuType {
        case .phone:
            AppFont.medium.s14
        default:
            AppFont.medium.s16
        }
    }
    
    override func menuAttachmentPoint(for configuration: UIContextMenuConfiguration) -> CGPoint {
        let original = super.menuAttachmentPoint(for: configuration)
        return menuType == .phone ? original : CGPoint(x: 16, y: original.y)
    }
}

private extension MenuButton {
    func setup() {
        showsMenuAsPrimaryAction = true
        menu = UIMenu(title: menuTitle, children: menuItems)
        setTitle(title, for: .normal)
        set(font: font, titleColor: AppColor.Static.darkGray.uiColor)
    }
}
