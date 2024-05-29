//
//  TabBarController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 11.03.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    var didMainScreenSelect: Callback<UINavigationController>?
    var didFavoritesSelect: Callback<UINavigationController>?
    var didAddAnnouncementSelect: Callback<UINavigationController>?
    var didMessagesSelect: Callback<UINavigationController>?
    var didProfileSelect: Callback<UINavigationController>?
    var didViewAppear: Callback<UINavigationController>?
    
    private let viewModel: TabBarViewModel
    private let defaultVC: UINavigationController
    private let tabBarItems = TabBarItem.allCases
    
    // MARK: - Object Lifecycle
    
    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        self.defaultVC = UINavigationController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupControllers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didViewAppear?(defaultVC)
    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            if let controller = viewController as? UINavigationController {
                didAddAnnouncementSelect?(controller)
            }
            return false
        }
        return true
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let controller = viewControllers?[item.tag] as? UINavigationController else { return }
        switch TabBarItem(rawValue: item.tag) {
        case .main:
            didMainScreenSelect?(controller)
        case .favorites:
            didFavoritesSelect?(controller)
        case .messages:
            didMessagesSelect?(controller)
        case .profile:
            didProfileSelect?(controller)
        default:
            break
        }
    }
}

// MARK: - Setup

private extension TabBarController {
    func setup() {
        tabBar.tintColor = AppColor.Theme.mainTitle.uiColor
        tabBar.unselectedItemTintColor = AppColor.Static.darkGray.uiColor
        tabBar.backgroundColor = AppColor.Theme.blockBackground.uiColor
        tabBar.barTintColor = AppColor.Theme.blockBackground.uiColor
        delegate = self
    }
    
    func setupControllers() {
        var vcs: [UINavigationController] = []
        tabBarItems.forEach { item in
            let vc: UINavigationController
            switch item {
            case .main:
                vc = defaultVC
            default:
                vc = UINavigationController()
            }
            vc.tabBarItem = UITabBarItem(title: item.title, image: item.icon, selectedImage: item.selectedIcon)
            if item == .add {
                vc.tabBarItem.setTitleTextAttributes(
                    [NSAttributedString.Key.foregroundColor: AppColor.Static.orange.uiColor],
                    for: .normal
                )
            }
            vc.tabBarItem.tag = item.rawValue
            vcs.append(vc)
        }
        viewControllers = vcs
    }
}
