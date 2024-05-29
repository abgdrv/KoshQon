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
    
    var finishFlow: Callback<Bool>?
    
    private let router: RouterProtocol
    private let factory: ProfileFlowFactory
    private let coordinatorFactory: CoordinatorFactory
    
    private let profileType: ProfileType
    
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, factory: ProfileFlowFactory, coordinatorFactory: CoordinatorFactory, profileType: ProfileType) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        self.profileType = profileType
        super.init(alertFlowFactory: factory)
    }
    
    override func start() {
        showProfile()
    }
}

private extension ProfileCoordinator {
    func showProfile() {
        let view = factory.makeProfileView(type: profileType)
        view.didSettingsTap = { [weak self] in
            guard let self = self else { return }
            self.showSettingsFlow()
        }
        view.didEditProfileTap = { [weak self] in
            guard let self = self else { return }
            self.showEditProfileFlow()
        }
        view.didFriendsTap = { [weak self] in
            guard let self = self else { return }
            self.showFriendsFlow()
        }
        if profileType == .myProfile {
            router.setRoodModule(view, hideNavBar: false, isAnimated: false)
        } else {
            router.push(view)
        }
    }
    
    func showSettingsFlow() {
        var coordinator = coordinatorFactory.makeSettingsCoordinator(router: router, coordinatorFactory: coordinatorFactory)
        coordinator.finishFlow = { [weak self] isQuit in
            guard let self = self else { return }
            self.removeDependency(coordinator)
            self.finishFlow?(isQuit)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func showEditProfileFlow() {
        var coordinator = coordinatorFactory.makeEditProfileCoordinator(router: router)
        coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.removeDependency(coordinator)
        }
        coordinator.profile = ProfileViewModel(profileType: .myProfile).profile
        addDependency(coordinator)
        coordinator.start()
    }
    
    func showFriendsFlow() {
        var coordinator = coordinatorFactory.makeFriendsCoordinator(router: router, coordinatorFactory: coordinatorFactory)
        coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
