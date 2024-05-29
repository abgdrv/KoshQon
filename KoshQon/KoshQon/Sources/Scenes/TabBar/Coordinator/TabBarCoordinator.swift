//
//  TabBarCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 25.03.2024.
//

import Foundation
import UIKit
import ProgressHUD

final class TabBarCoordinator: BaseCoordinator, TabBarOutputCoordinator {
    
    // MARK: - Properties
    
    var didSessionExpired: VoidCallback?
    var finishFlow: Callback<Bool>?
    
    private let router: RouterProtocol
    private let factory: TabBarFlowFactory
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private var navController: UINavigationController?
    
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, factory: TabBarFlowFactory, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        super.init(alertFlowFactory: factory)
    }
    
    override func start() {
        showTabBar()
    }
}

private extension TabBarCoordinator {
    func showTabBar() {
        let tabBarView = factory.makeTabBarView()
        let showMainScreenFlow = showMainScreenFlow()
        let showFavoritesFlow = showFavoritesFlow()
        let showAddAnnouncementFlow = showAddAnnouncementFlow()
        let showMessagesFlow = showMessagesFlow()
        let showProfileFlow = showProfileFlow()
        tabBarView.didViewAppear = showMainScreenFlow
        tabBarView.didMainScreenSelect = showMainScreenFlow
        tabBarView.didFavoritesSelect = showFavoritesFlow
        tabBarView.didAddAnnouncementSelect = showAddAnnouncementFlow
        tabBarView.didMessagesSelect = showMessagesFlow
        tabBarView.didProfileSelect = showProfileFlow
        router.setRootModule(tabBarView, hideNavBar: true)
    }
    
    func showMainScreenFlow() -> Callback<UINavigationController> {
        return { [unowned self] navController in
            self.navController = navController
            if navController.viewControllers.isEmpty {
                var coordinator = self.coordinatorFactory.makeMainScreenCoordinator(navController: navController)
                coordinator.finishFlow = { [weak self] in
                    guard let self = self else { return }
                    self.removeDependency(coordinator)
                    self.finishFlow?(true)
                }
                coordinator.reloadFlow = { [weak self] in
                    guard let self = self else { return }
                    self.start()
                }
                self.addDependency(coordinator)
                coordinator.start()
            }
        }
    }
    
    func showFavoritesFlow() -> Callback<UINavigationController> {
        return { [unowned self] navController in
            self.navController = navController
            if navController.viewControllers.isEmpty {
                var coordinator = self.coordinatorFactory.makeFavoritesCoordinator(navController: navController)
                coordinator.finishFlow = { [weak self] in
                    guard let self = self else { return }
                    self.removeDependency(coordinator)
                    self.finishFlow?(true)
                }
                self.addDependency(coordinator)
                coordinator.start()
            }
        }
    }
    
    func showAddAnnouncementFlow() -> Callback<UINavigationController> {
        return { [unowned self] navController in
            self.navController = navController
            if navController.viewControllers.isEmpty {
                var coordinator = self.coordinatorFactory.makeAddAnnouncementCoordinator(navController: navController)
                coordinator.finishFlow = { [weak self] in
                    guard let self = self else { return }
                    self.removeDependency(coordinator)
                    self.finishFlow?(true)
                }
                self.addDependency(coordinator)
                coordinator.start()
            }
        }
    }
    
    func showProfileFlow() -> Callback<UINavigationController> {
        return { [unowned self] navController in
            self.navController = navController
            if navController.viewControllers.isEmpty {
                var coordinator = self.coordinatorFactory.makeProfileCoordinator(profileType: .myProfile, navController: navController)
                coordinator.finishFlow = { [weak self] isQuit in
                    guard let self = self else { return }
                    ProgressHUD.animate()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        ProgressHUD.dismiss()
                        self.removeDependency(coordinator)
                        self.finishFlow?(isQuit)
                    }
                }
                self.addDependency(coordinator)
                coordinator.start()
            }
        }
    }
    
    func showMessagesFlow() -> Callback<UINavigationController> {
        return { [unowned self] navController in
            self.navController = navController
            if navController.viewControllers.isEmpty {
                var coordinator = self.coordinatorFactory.makeMessagesCoordinator(navController: navController)
                coordinator.finishFlow = { [weak self] in
                    guard let self = self else { return }
                    self.removeDependency(coordinator)
                    self.finishFlow?(true)
                }
                self.addDependency(coordinator)
                coordinator.start()
            }
        }
    }
}
