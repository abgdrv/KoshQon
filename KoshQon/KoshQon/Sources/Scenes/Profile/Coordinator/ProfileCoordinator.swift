//
//  ProfileCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import Foundation
import UIKit

final class ProfileCoordinator: BaseCoordinator, ProfileOutputCoordinator {
    
    // MARK: - Properties
    
    var finishFlow: VoidCallback?
    
    private let router: RouterProtocol
    private let factory: ProfileFlowFactory
    private let coordinatorFactory: CoordinatorFactory
    
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, factory: ProfileFlowFactory, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        super.init(alertFlowFactory: factory)
    }
    
    override func start() {
        showProfile()
    }
}

private extension ProfileCoordinator {
    func showProfile() {
        let view = factory.makeProfileView()
        view.didSettingsTap = { [weak self] in
            guard let self = self else { return }
            self.showSettingsFlow()
        }
        view.didEditProfileTap = { [weak self] profile in
            guard let self = self else { return }
            self.showEditProfileFlow(profile: profile)
        }
        router.setRoodModule(view, hideNavBar: false, isAnimated: false)
    }
    
    func showSettingsFlow() {
        var coordinator = coordinatorFactory.makeSettingsCoordinator(router: router)
        coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func showEditProfileFlow(profile: Profile) {
        var coordinator = coordinatorFactory.makeEditProfileCoordinator(router: router)
        coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.removeDependency(coordinator)
        }
        coordinator.profile = profile
        addDependency(coordinator)
        coordinator.start()
    }
}
