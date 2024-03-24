//
//  SplashScreenCoordinator.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.03.2024.
//

import Foundation

final class SplashScreenCoordinator: BaseCoordinator, SplashScreenOutputCoordinator {
    
    // MARK: - Properties
    
    var finishFlow: VoidCallback?
    
    private let router: RouterProtocol
    private let factory: SplashScreenFlowFactory
    
    // MARK: - Object Lifecycle
    
    init(router: RouterProtocol, factory: SplashScreenFlowFactory) {
        self.router = router
        self.factory = factory
        super.init(alertFlowFactory: factory)
    }
    
    override func start() {
        showSplashScreen()
    }
}

// MARK: - Private methods

private extension SplashScreenCoordinator {
    func showSplashScreen() {
        let view = factory.makeSplashScreen()
        view.didFinish = { [weak self] in
            guard let self = self else { return }
            self.finishFlow?()
        }
        router.setRootModule(view, hideNavBar: true)
    }
}
