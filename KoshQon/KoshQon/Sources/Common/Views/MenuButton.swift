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
    
    var menuType: MenuType? {
        didSet {
            setup()
        }
    }
    
    private static var country: Country?
    
    private lazy var countries = Country.allCases
    private lazy var genders: [Gender] = [.male, .female]
    
    private var menuItems: [UIAction] {
        var menuItems: [UIAction] = []
        switch menuType {
        case .phone:
            countries.forEach { country in
                menuItems.append(UIAction(title: country.fullTitle, handler: { action in
                    self.setTitle(country.phoneCodeTitle, for: .normal)
                }))
            }
        case .gender:
            genders.forEach { gender in
                menuItems.append(UIAction(title: gender.title, handler: { action in
                    self.didSelect?(gender.title)
                }))
            }
        case .city:
            guard let country = MenuButton.country else { return [] }
            country.cities.forEach { city in
                menuItems.append(UIAction(title: city, handler: { action in
                    self.didSelect?(city)
                }))
            }
        case .country:
            countries.forEach { country in
                menuItems.append(UIAction(title: country.countryTitle, handler: { action in
                    MenuButton.country = country
                    self.didSelect?(country.title)
                    self.didCountrySelect?()
                }))
            }
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
            Country.kz.phoneCodeTitle
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
        return CGPoint(x: 16, y: original.y)
    }
}

private extension MenuButton {
    func setup() {
        showsMenuAsPrimaryAction = true
        menu = UIMenu(title: menuTitle, children: menuItems)
        setTitle(title, for: .normal)
        titleLabel?.font = font
        setTitleColor(AppColor.Static.darkGray.uiColor, for: .normal)
    }
}
