//
//  MainTabBarController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 11.03.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    private let viewModel: MainTabBarViewModel
    
    // MARK: - Object Lifecycle
    
    init(viewModel: MainTabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = AppColor.Theme.mainTitle.uiColor
        tabBar.unselectedItemTintColor = AppColor.Static.darkGray.uiColor
        tabBar.backgroundColor = AppColor.Theme.mainBackground.uiColor
        selectedViewController = viewControllers?.first
        delegate = self
        setupViewControllers()
    }
}

// MARK: - Setup

private extension MainTabBarController {
    func setupViewControllers() {
        let home = UINavigationController(rootViewController: MainScreenViewController(viewModel: MainScreenViewModel()))
        home.tabBarItem = UITabBarItem(title: "KoshQon",
                                       image: AppImage.Tabbar.logo.uiImage,
                                       selectedImage: AppImage.Tabbar.logoSelected.uiImage)
        
        let favourites = UINavigationController(rootViewController: FavoritesViewController(viewModel: FavoritesViewModel()))
        favourites.tabBarItem = UITabBarItem(title: "Избранное",
                                             image: AppImage.Tabbar.favourites.uiImage,
                                             selectedImage: AppImage.Tabbar.favouritesSelected.uiImage)
        
        let add = UIViewController()
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
        
        let profile = UINavigationController(rootViewController: ProfileViewViewController(viewModel: ProfileViewModel()))
        profile.tabBarItem = UITabBarItem(title: "Профиль",
                                          image: AppImage.Tabbar.profile.uiImage,
                                          selectedImage: AppImage.Tabbar.profileSelected.uiImage)
        
        viewControllers = [home, favourites, add, messages, profile]
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            let addController = UIViewController().apply {
                $0.view.backgroundColor = .red
            }
            addController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .plain, target: self, action: #selector(close))
            let someNavController = UINavigationController(rootViewController: addController)
            someNavController.modalPresentationStyle = .overFullScreen
            self.present(someNavController, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    @objc func close() {
        dismiss(animated: true)
    }
}
