//
//  AppCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.03.2024.
//

import Foundation
import UIKit

final class AppCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    
    private let coordinatorFactory: CoordinatorFactory
    private let router: RouterProtocol
    private let appThemeService = AppThemeService.shared
    
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        runSplashScreenFlow()
        applyTheme()
    }
}

private extension AppCoordinator {
    func runSplashScreenFlow() {
        var coordinator = coordinatorFactory.makeSplashScreenCoordinator(router: router)
        coordinator.finishFlow = { [weak self] in
            self?.removeDependency(coordinator)
            self?.runAuthFlow()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func runAuthFlow() {
        var coordinator = coordinatorFactory.makeAuthCoordinator(router: router,
                                                                 coordinatorFactory: coordinatorFactory)
        coordinator.finishFlow = { [weak self] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func applyTheme() {
        let appTheme = appThemeService.getCurrentTheme()
        appThemeService.updateThemeState(with: appTheme)
    }
}
