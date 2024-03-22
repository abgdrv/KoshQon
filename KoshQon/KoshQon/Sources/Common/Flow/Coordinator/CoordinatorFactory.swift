//
//  CoordinatorFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.03.2024.
//

import Foundation
import UIKit

protocol CoordinatorFactoryProtocol {
    func makeSplashScreenCoordinator(router: RouterProtocol) -> Coordinator & SplashScreenOutputCoordinator
    func makeAuthCoordinator(router: RouterProtocol,
                             coordinatorFactory: CoordinatorFactoryProtocol) -> Coordinator & AuthOutputCoordinator
    func makeRegisterCoordinator(router: RouterProtocol) -> Coordinator & RegisterOutputCoordinator
    func makeForgotPasswordCoordinator(router: RouterProtocol) -> Coordinator & ForgotPasswordOutputCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    
    func makeSplashScreenCoordinator(router: RouterProtocol) -> Coordinator & SplashScreenOutputCoordinator {
        let coordinator = SplashScreenCoordinator(router: router, factory: FlowFactory.shared)
        return coordinator
    }
    
    func makeAuthCoordinator(router: RouterProtocol,
                             coordinatorFactory: CoordinatorFactoryProtocol) -> Coordinator & AuthOutputCoordinator {
        let coordinator = AuthCoordinator(router: router, factory: FlowFactory.shared,
                                          coordinatorFactory: coordinatorFactory)
        return coordinator
    }
    
    func makeRegisterCoordinator(router: RouterProtocol) -> Coordinator & RegisterOutputCoordinator {
        let coordinator = RegisterCoordinator(router: router, factory: FlowFactory.shared)
        return coordinator
    }
    
    func makeForgotPasswordCoordinator(router: RouterProtocol) -> Coordinator & ForgotPasswordOutputCoordinator {
        let coordinator = ForgotPasswordCoordinator(router: router, factory: FlowFactory.shared)
        return coordinator
    }
    
}

private extension CoordinatorFactory {
    func router(_ navController: UINavigationController?) -> Router {
        return Router(rootController: navigationController(navController))
    }
    
    func navigationController(_ navController: UINavigationController?) -> UINavigationController {
        if let navController = navController { return navController }
        else { return UINavigationController() }
    }
}
