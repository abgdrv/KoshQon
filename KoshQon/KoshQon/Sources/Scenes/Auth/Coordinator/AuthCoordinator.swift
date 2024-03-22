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
    
    private let factory: AuthFlowFactory
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, factory: AuthFlowFactory, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        showLoginFlow()
    }
}

private extension AuthCoordinator {
    func showLoginFlow() {
        let view = factory.makeLoginView()
        view.didLogin = {
        }
        router.present(view, transitionStyle: .crossDissolve )
    }
    
    func showRegisterFlow() {
        let view = factory.makeRegisterView()
        router.push(view)
    }
}

