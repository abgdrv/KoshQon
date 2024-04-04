//
//  CoordinatorFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.03.2024.
//

import Foundation
import UIKit

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeSplashScreenCoordinator(router: RouterProtocol) -> Coordinator & SplashScreenOutputCoordinator {
        let coordinator = SplashScreenCoordinator(router: router, factory: FlowFactory())
        return coordinator
    }
    
    func makeAuthCoordinator(router: RouterProtocol,
                             coordinatorFactory: CoordinatorFactoryProtocol) -> Coordinator & AuthOutputCoordinator {
        let coordinator = AuthCoordinator(router: router, factory: FlowFactory(),
                                          coordinatorFactory: coordinatorFactory)
        return coordinator
    }
    
    func makeEnterPhoneCoordinator(type: EnterPhoneType, router: RouterProtocol) -> Coordinator & EnterPhoneOutputCoordinator {
        let coordinator = EnterPhoneCoordinator(type: type, router: router, factory: FlowFactory())
        return coordinator
    }
    
    func makeTabBarCoordinator(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol) -> Coordinator & TabBarOutputCoordinator {
        let coordinator = TabBarCoordinator(router: router, factory: FlowFactory(), coordinatorFactory: coordinatorFactory)
        return coordinator
    }
    
    func makeMainScreenCoordinator(navController: UINavigationController) -> Coordinator & MainScreenOutputCoordinator {
        let coordinator = MainScreenCoordinator(router: router(navController), factory: FlowFactory(), coordinatorFactory: self)
        return coordinator
    }
    
    func makeFavoritesCoordinator(navController: UINavigationController) -> Coordinator & FavoritesOutputCoordinator {
        let coordinator = FavoritesCoordinator(router: router(navController), factory: FlowFactory(), coordinatorFactory: self)
        return coordinator
    }
    
    func makeAddAnnouncementCoordinator(navController: UINavigationController) -> AddAnnouncementOutputCoordinator & Coordinator {
        let coordinator = AddAnnouncementCoordinator(router: router(navController), factory: FlowFactory())
        return coordinator
    }
    
    func makeProfileCoordinator(navController: UINavigationController) -> Coordinator & ProfileOutputCoordinator {
        let coordinator = ProfileCoordinator(router: router(navController), factory: FlowFactory(), coordinatorFactory: self)
        return coordinator
    }
    
    func makeSettingsCoordinator(router: RouterProtocol, coordinatorFactory: CoordinatorFactory) -> Coordinator & SettingsOutputCoordinator {
        let coordinator = SettingsCoordinator(router: router, factory: FlowFactory(), coordinatorFactory: coordinatorFactory)
        return coordinator
    }
    
    func makeEditProfileCoordinator(router: RouterProtocol) -> Coordinator & EditProfileOutputCoordinator {
        let coordinator = EditProfileCoordinator(router: router, factory: FlowFactory(), coordinatorFactory: self)
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
