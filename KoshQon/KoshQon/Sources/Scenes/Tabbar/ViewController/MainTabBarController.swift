//
//  MainTabBarController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 11.03.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup

private extension MainTabBarController {
    func getViewControllers() -> [UIViewController] {
        let home = UINavigationController(rootViewController: MainScreenViewController())
        home.tabBarItem = UITabBarItem(title: "KoshQon",
                                       image: AppImage.Tabbar.logo.uiImage,
                                       selectedImage: AppImage.Tabbar.logoSelected.uiImage)
        
        let favourites = UINavigationController(rootViewController: UIViewController().apply({
            $0.view.backgroundColor = .white
        }))
        favourites.tabBarItem = UITabBarItem(title: "Избранное",
                                             image: AppImage.Tabbar.favourites.uiImage,
                                             selectedImage: AppImage.Tabbar.favouritesSelected.uiImage)
        
        let add = UINavigationController(rootViewController: UIViewController().apply({
            $0.view.backgroundColor = .white
        }))
        add.tabBarItem = UITabBarItem(title: "Подать",
                                      image: AppImage.Tabbar.add.uiImage?.withRenderingMode(.alwaysOriginal),
                                      selectedImage: AppImage.Tabbar.add.uiImage?.withRenderingMode(.alwaysOriginal))
        add.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:
                                               AppColor.Static.orange.uiColor],
                                              for: .normal)
        
        let messages = UINavigationController(rootViewController: UIViewController().apply({
            $0.view.backgroundColor = .white
        }))
        messages.tabBarItem = UITabBarItem(title: "Сообщения",
                                           image: AppImage.Tabbar.messages.uiImage,
                                           selectedImage: AppImage.Tabbar.messagesSelected.uiImage)
        
        let profile = UINavigationController(rootViewController: UIViewController().apply({
            $0.view.backgroundColor = .white
        }))
        profile.tabBarItem = UITabBarItem(title: "Профиль",
                                          image: AppImage.Tabbar.profile.uiImage,
                                          selectedImage: AppImage.Tabbar.profileSelected.uiImage)
        
        return [home, favourites, add, messages, profile]
    }
    
    func setup() {
        tabBar.tintColor = AppColor.Theme.mainTitle.uiColor
        tabBar.unselectedItemTintColor = AppColor.Static.darkGray.uiColor
        tabBar.backgroundColor = AppColor.Theme.mainBackground.uiColor
        viewControllers = getViewControllers()
        selectedViewController = viewControllers?.first
    }
}
