//
//  AuthCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.03.2024.
//

import Foundation
import ProgressHUD

final class AuthCoordinator: BaseCoordinator, AuthOutputCoordinator {
    
    // MARK: - Properties
    
    var finishFlow: VoidCallback?
    
    private let router: RouterProtocol
    private let factory: AuthFlowFactory
    private let coordinatorFactory: CoordinatorFactoryProtocol
    
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, factory: AuthFlowFactory, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        super.init(alertFlowFactory: factory)
    }
    
    override func start() {
        showLogin()
    }
}

private extension AuthCoordinator {
    func showLogin() {
        let view = factory.makeLoginView()
        view.didForgot = { [weak self] in
            guard let self = self else { return }
            self.showForgotPasswordFlow()
        }
        view.didLogin = { [weak self] in
            guard let self = self else { return }
            self.finishFlow?()
        }
        view.didRegister = { [weak self] in
            guard let self = self else { return }
            self.showRegisterFlow()
        }
        router.setRootModule(view, hideNavBar: true)
    }
    
    func showRegisterFlow() {
        var coordinator = coordinatorFactory.makeEnterPhoneCoordinator(type: .registration, router: router)
        coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            ProgressHUD.success("Success", delay: 1.5)
            self.router.popToRootModule(animated: true)
            self.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func showForgotPasswordFlow() {
        var coordinator = coordinatorFactory.makeEnterPhoneCoordinator(type: .forgotPassword, router: router)
        coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.router.popToRootModule(animated: true)
            self.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}

