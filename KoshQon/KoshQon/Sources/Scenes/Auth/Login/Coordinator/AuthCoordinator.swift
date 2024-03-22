//
//  AuthCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.03.2024.
//

import Foundation

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
        view.didLogin = {
            
        }
        view.didRegister = { [weak self] in
            guard let self = self else { return }
            self.showRegisterFlow()
        }
        router.setRootModule(view, hideNavBar: true)
    }
    
    func showRegisterFlow() {
        var coordinator = coordinatorFactory.makeRegisterCoordinator(router: router)
        coordinator.finishFlow = { [weak self] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func showForgotPasswordFlow() {
        var coordinator = coordinatorFactory.makeForgotPasswordCoordinator(router: router)
        coordinator.finishFlow = { [weak self] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}

