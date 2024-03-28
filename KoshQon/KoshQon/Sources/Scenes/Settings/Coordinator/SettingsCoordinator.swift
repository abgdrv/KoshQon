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
        
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, factory: SettingsFlowFactory) {
        self.router = router
        self.factory = factory
        super.init(alertFlowFactory: factory)
    }
    
    override func start() {
        showSettings()
    }
}

private extension SettingsCoordinator {
    func showSettings() {
        let view = factory.makeSettingsView()
        view.didNavigationCellSelect = { [weak self] type in
            guard let self = self else { return }
            self.openNavigationCell(type: type)
        }
        router.push(view)
    }
    
    func showPersonal() {
        
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
    
    func openNavigationCell(type: NavigationCellType) {
        switch type {
        case .personal:
            showPersonal()
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
