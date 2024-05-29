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
    
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactory
    private let appThemeService = AppThemeService.shared
    
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        super.init()
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
            guard let self = self else { return }
            self.removeDependency(coordinator)
            self.checkAuth()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func checkAuth() {
        if let _ = UserDefaultsService.shared.value(for: KeychainKeys.passcode.rawValue) as? String {
            runPasscodeFlow()
        } else {
            runAuthFlow()
        }
    }
    
    func runAuthFlow() {
        var coordinator = coordinatorFactory.makeAuthCoordinator(router: router, coordinatorFactory: coordinatorFactory)
        coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.removeDependency(coordinator)
            self.runPasscodeFlow()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func runPasscodeFlow() {
        let passcodeType: PassCodeType
        if let _ = UserDefaultsService.shared.value(for: KeychainKeys.passcode.rawValue) as? String {
            passcodeType = .verify
        } else {
            passcodeType = .enter
        }
        
        var coordinator = coordinatorFactory.makePassCodeCoordinator(passcodeType: passcodeType, router: router)
        coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.removeDependency(coordinator)
            self.runTabBarFlow()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func runTabBarFlow() {
        var coordinator = coordinatorFactory.makeTabBarCoordinator(router: router, coordinatorFactory: coordinatorFactory)
        coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.removeDependency(coordinator)
            self.runAuthFlow()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func applyTheme() {
        let appTheme = appThemeService.getCurrentTheme()
        appThemeService.updateThemeState(with: appTheme)
    }
}
