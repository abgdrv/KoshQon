//
//  PassCodeCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 13.05.2024.
//

import Foundation

final class PassCodeCoordinator: BaseCoordinator, PassCodeOutputCoordinator {
    
    // MARK: - Properties
    
    var finishFlow: VoidCallback?
    
    private let passcodeType: PassCodeType
    
    private let router: RouterProtocol
    private let factory: PassCodeFlowFactory
    
    // MARK: - Object Lifecycle
    
    init(passcodeType: PassCodeType, router: RouterProtocol, factory: PassCodeFlowFactory) {
        self.passcodeType = passcodeType
        self.router = router
        self.factory = factory
        super.init(alertFlowFactory: factory)
    }
    
    override func start() {
        showPasscode(type: passcodeType)
    }
}

private extension PassCodeCoordinator {
    func showPasscode(type: PassCodeType) {
        let view = factory.makePasscodeView(type: type)
        view.passcodeDidEnter = { [weak self] isVerify in
            guard let self = self else { return }
            if type == .enter {
                showPasscode(type: .verify)
            } else {
                self.finishFlow?()
            }
        }
        router.push(view)
    }
}
