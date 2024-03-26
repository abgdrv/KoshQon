//
//  ForgotPasswordCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.03.2024.
//

import Foundation

final class ForgotPasswordCoordinator: BaseCoordinator, ForgotPasswordOutputCoordinator {
    
    // MARK: - Properties
    
    var finishFlow: VoidCallback?
    
    private let router: RouterProtocol
    private let factory: RegisterFlowFactory
    
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, factory: RegisterFlowFactory) {
        self.router = router
        self.factory = factory
        super.init(alertFlowFactory: factory)
    }
    
    override func start() {
        showForgotPassword()
    }
}

private extension ForgotPasswordCoordinator {
    func showForgotPassword() {
        let view = factory.makeEnterPhoneView(type: .forgotPassword)
        view.didFinish = { [weak self] in
            guard let self = self else { return }
            self.showSmsCode()
        }
        router.push(view)
    }
    
    func showSmsCode() {
        let view = factory.makeSmsCodeView()
        view.didFinish = { [weak self] in
            guard let self = self else { return }
            self.showChangePassword()
        }
        router.push(view)
    }
    
    func showChangePassword() {
        let view = factory.makeSetPasswordView(type: .change)
        view.didFinish = { [weak self] in
            guard let self = self else { return }
            self.router.popToRootModule(animated: true)
        }
        router.push(view)
    }
}
