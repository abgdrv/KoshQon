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
    var didAddSelect: Callback<UINavigationController>?
    var didMessagesSelect: Callback<UINavigationController>?
    var didProfileSelect: Callback<UINavigationController>?
    
    private let viewModel: TabBarViewModel
//    private let defaultVC: UINavigationController
    private let tabBarItems = TabBarItemType.allCases
    
    // MARK: - Object Lifecycle
    
    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
//        self.defaultVC = UINavigationController()
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
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
//            let addController = UIViewController().apply {
//                $0.view.backgroundColor = .red
//            }
//            addController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .plain, target: self, action: #selector(close))
//            let someNavController = UINavigationController(rootViewController: addController)
//            someNavController.modalPresentationStyle = .overFullScreen
//            self.present(someNavController, animated: true, completion: nil)
            if let controller = viewController as? UINavigationController {
                didAddSelect?(controller)
            }
            return false
        }
        return true
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let controller = viewControllers?[item.tag] as? UINavigationController else { return }
        switch TabBarItemType(rawValue: item.tag) {
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
        tabBar.backgroundColor = AppColor.Theme.mainBackground.uiColor
        selectedViewController = viewControllers?.first
        delegate = self
    }
    
    func setupControllers() {
        var vcs: [UINavigationController] = []
        tabBarItems.forEach { item in
            let vc: UINavigationController
            switch item {
            case .add:
                vc = UINavigationController()
                vc.tabBarItem.setTitleTextAttributes(
                    [NSAttributedString.Key.foregroundColor: AppColor.Static.orange.uiColor],
                    for: .normal
                )
            default:
                vc = UINavigationController()
            }
            vc.tabBarItem = UITabBarItem(title: item.title, image: item.icon, selectedImage: item.selectedIcon)
            vc.tabBarItem.tag = item.rawValue
            vcs.append(vc)
        }
        viewControllers = vcs
    }
}
