//
//  SettingsCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 27.03.2024.
//

import Foundation

final class SettingsCoordinator: BaseCoordinator, SettingsOutputCoordinator {
    
    // MARK: - Properties
    
    var finishFlow: VoidCallback?
    
    private let router: RouterProtocol
    private let factory: SettingsFlowFactory
    private let coordinatorFactory: CoordinatorFactory
        
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, factory: SettingsFlowFactory, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        super.init(alertFlowFactory: factory)
    }
    
    override func start() {
        showSettings()
    }
}

private extension SettingsCoordinator {
    func showSettings() {
        let view = factory.makeSettingsView()
        view.didNavigationCellTap = { [weak self] type in
            guard let self = self else { return }
            self.showNavigationCell(type: type)
        }
        router.push(view)
    }
    
    func showEditProfile() {
        var coordinator = coordinatorFactory.makeEditProfileCoordinator(router: router)
        coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.removeDependency(coordinator)
        }
        coordinator.profile = ProfileViewModel().profile
        addDependency(coordinator)
        coordinator.start()
    }
    
    func showPrivacy() {
        
    }
    
    func showTheme() {
        
    }
    
    func showLanguage() {
        
    }
    
    func showAbout() {
        
    }
    
    func showQuit() {
        
    }
    
    func showNavigationCell(type: NavigationCellType) {
        switch type {
        case .personal:
            showEditProfile()
        case .privacy:
            showPrivacy()
        case .theme:
            showTheme()
        case .language:
            showLanguage()
        case .about:
            showAbout()
        case .quit:
            showQuit()
        default:
            break
        }
    }
}
