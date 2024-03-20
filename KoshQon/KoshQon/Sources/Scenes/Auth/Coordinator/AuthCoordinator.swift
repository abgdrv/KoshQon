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
    
    init(factory: AuthFlowFactory, router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.factory = factory
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        showSignInFlow()
    }
}

private extension AuthCoordinator {
    func showSignInFlow() {
        let view = factory.makeSignInView()
        view.didFinish = {
            router.
        }
        router.present(view, transitionStyle: .crossDissolve )
    }
    
    func showSignUpFlow() {
        let view = factory.makeSignUpView()
        router.push(view)
    }
}

