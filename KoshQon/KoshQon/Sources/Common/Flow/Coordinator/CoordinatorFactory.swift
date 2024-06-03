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
    
    func makeTabBarCoordinator(isFirst: Bool, router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol) -> Coordinator & TabBarOutputCoordinator {
        let coordinator = TabBarCoordinator(isFirst: isFirst, router: router, factory: FlowFactory(), coordinatorFactory: coordinatorFactory)
        return coordinator
    }
    
    func makeMainScreenCoordinator(isFirst: Bool, navController: UINavigationController) -> Coordinator & MainScreenOutputCoordinator {
        let coordinator = MainScreenCoordinator(isFirst: isFirst, router: router(navController), factory: FlowFactory(), coordinatorFactory: self)
        return coordinator
    }
    
    func makeFavoritesCoordinator(navController: UINavigationController) -> Coordinator & AnnouncementsOutputCoordinator {
        let coordinator = AnnouncementsCoordinator(router: router(navController), factory: FlowFactory(), coordinatorFactory: self)
        return coordinator
    }
    
    func makeAddAnnouncementCoordinator(navController: UINavigationController) -> AddAnnouncementOutputCoordinator & Coordinator {
        let coordinator = AddAnnouncementCoordinator(router: router(navController), factory: FlowFactory())
        return coordinator
    }
    
    func makeProfileCoordinator(user: User, profileType: ProfileType, navController: UINavigationController) -> Coordinator & ProfileOutputCoordinator {
        let coordinator = ProfileCoordinator(user: user, router: router(navController), factory: FlowFactory(), coordinatorFactory: self, profileType: profileType)
        return coordinator
    }
    
    func makeProfileCoordinator(user: User, profileType: ProfileType, router: RouterProtocol) -> Coordinator & ProfileOutputCoordinator {
        let coordinator = ProfileCoordinator(user: user, router: router, factory: FlowFactory(), coordinatorFactory: self, profileType: profileType)
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
    
    func makeFriendsCoordinator(router: RouterProtocol, coordinatorFactory: CoordinatorFactory) -> Coordinator & FriendsOutputCoordinator {
        let coordinator = FriendsCoordinator(router: router, factory: FlowFactory(), coordinatorFactory: coordinatorFactory)
        return coordinator
    }
    
    func makePassCodeCoordinator(passcodeType: PassCodeType, router: RouterProtocol) -> Coordinator & PassCodeOutputCoordinator {
        let coordinator = PassCodeCoordinator(passcodeType: passcodeType, router: router, factory: FlowFactory())
        return coordinator
    }
    
    func makeMessagesCoordinator(navController: UINavigationController) -> Coordinator & MessagesOutputCoordinator {
        let coordinator = MessagesCoordinator(router: router(navController), factory: FlowFactory(), coordinatorFactory: self)
        return coordinator
    }
    
    func makeAnnouncementDetailsCoordinator(announcement: Announcement, router: RouterProtocol) -> Coordinator & AnnouncementDetailsOutputCoordinator {
        let coordinator = AnnouncementDetailsCoordinator(announcement: announcement, router: router, factory: FlowFactory())
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
