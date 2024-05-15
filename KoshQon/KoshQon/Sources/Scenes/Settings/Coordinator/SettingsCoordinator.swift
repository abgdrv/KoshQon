//
//  SettingsCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 27.03.2024.
//

import Foundation
import UIKit

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
        coordinator.profile = ProfileViewModel(profileType: .myProfile).profile
        addDependency(coordinator)
        coordinator.start()
    }
    
    func showPrivacy() {
        let view = factory.makePrivacyView()
        view.didDeactivateCellTap = { [weak self] completion in
            guard let self = self else { return }
            self.showDeactivateAlert(completion: completion)
        }
        router.push(view)
    }
    
    func showTheme() {
        let view = factory.makeThemeView()
        router.push(view)
    }
    
    func showLanguage() {
        
    }
    
    func showAbout() {
        
    }
    
    func showQuit() {
        let actions: [UIAlertAction] = [
            UIAlertAction(title: "Выйти", style: .destructive, handler: { action in
                UserDefaultsService.shared.removeObject(for: KeychainKeys.passcode.rawValue)
                self.finishFlow?()
            }),
            UIAlertAction(title: "Отмена", style: .cancel)
        ]
        let alert = factory.makeAlert(title: "Выйти?", message: nil, with: actions)
        router.toPresent()?.present(alert, animated: true)
    }
}

private extension SettingsCoordinator {
    func showNavigationCell(type: NavigationCellType) {
        switch type {
        case .settings(let settingsType):
            switch settingsType {
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
            }
        default:
            break
        }
    }
    
    func showDeactivateAlert(completion: @escaping VoidCallback) {
        let actions: [UIAlertAction] = [
            UIAlertAction(title: "Деактивировать", style: .destructive, handler: { action in
                completion()
            }),
            UIAlertAction(title: "Отмена", style: .cancel)
        ]
        let alert = factory.makeAlert(title: "Деактивировать аккаунт?", message: nil, with: actions)
        router.toPresent()?.present(alert, animated: true)
    }
}
