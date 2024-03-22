//
//  RegisterCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.03.2024.
//

import Foundation

final class RegisterCoordinator: BaseCoordinator, RegisterOutputCoordinator {
    
    // MARK: - Properties
    
    var finishFlow: VoidCallback?
    
    private let router: RouterProtocol
    private let factory: RegisterFlowFactory
    
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, factory: RegisterFlowFactory) {
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        showRegister()
    }
}

private extension RegisterCoordinator {
    func showRegister() {
        let view = factory.makeEnterPhoneView(type: .register)
        view.didFinish = { [weak self] in
            guard let self = self else { return }
            self.showSms()
        }
        router.push(view)
    }
    
    func showSms() {
        let view = factory.makeSmsCodeView()
        view.didFinish = { [weak self] in
            guard let self = self else { return }
            self.showPersonal()
        }
        router.push(view)
    }
    
    func showPersonal() {
        let view = factory.makePersonalView()
        view.didFinish = { [weak self] in
            guard let self = self else { return }
            self.showCreatePassword()
        }
        router.push(view)
    }
    
    func showCreatePassword() {
        let view = factory.makeSetPasswordView(type: .create)
        view.didFinish = { [weak self] in
            guard let self = self else { return }
            self.router.popToRootModule(animated: true)
        }
        router.push(view)
    }
}
