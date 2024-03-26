//
//  TabBarCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 25.03.2024.
//

import Foundation
import UIKit

final class TabBarCoordinator: BaseCoordinator, TabBarOutputCoordinator {
    
    // MARK: - Properties
    
    var didSessionExpired: VoidCallback?
    var finishFlow: VoidCallback?
    
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
        tabBarView.didViewAppear = showMainScreenFlow()
        tabBarView.didMainScreenSelect = showMainScreenFlow()
        tabBarView.didFavoritesSelect = showFavorites()
        tabBarView.didAddAnnouncementSelect = showAddAnnouncement()
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
                    self.finishFlow?()
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
    
    func showFavorites() -> Callback<UINavigationController> {
        return { [unowned self] navController in
            self.navController = navController
            if navController.viewControllers.isEmpty {
                var coordinator = self.coordinatorFactory.makeFavoritesCoordinator(navController: navController)
                coordinator.finishFlow = { [weak self] in
                    guard let self = self else { return }
                    self.removeDependency(coordinator)
                    self.finishFlow?()
                }
                self.addDependency(coordinator)
                coordinator.start()
            }
        }
    }
    
    func showAddAnnouncement() -> Callback<UINavigationController> {
        return { [unowned self] navController in
            self.navController = navController
            let view = factory.makeAddAnnouncementView()
            if navController.viewControllers.isEmpty {
                var coordinator = self.coordinatorFactory.makeAddAnnouncementCoordinator(navController: navController)
                coordinator.finishFlow = { [weak self] in
                    guard let self = self else { return }
                    self.removeDependency(coordinator)
                    self.finishFlow?()
                }
                self.addDependency(coordinator)
                coordinator.start()
            }
        }
    }
}
