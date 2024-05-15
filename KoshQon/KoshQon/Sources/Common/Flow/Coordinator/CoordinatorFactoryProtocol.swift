//
//  CoordinatorFactoryProtocol.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import Foundation
import UIKit

protocol CoordinatorFactoryProtocol {
    func makeSplashScreenCoordinator(router: RouterProtocol) -> Coordinator & SplashScreenOutputCoordinator
    func makeAuthCoordinator(router: RouterProtocol,
                             coordinatorFactory: CoordinatorFactoryProtocol) -> Coordinator & AuthOutputCoordinator
    func makeEnterPhoneCoordinator(type: EnterPhoneType, router: RouterProtocol) -> Coordinator & EnterPhoneOutputCoordinator
    func makeTabBarCoordinator(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol) -> Coordinator & TabBarOutputCoordinator
    func makeMainScreenCoordinator(navController: UINavigationController) -> Coordinator & MainScreenOutputCoordinator
    func makeFavoritesCoordinator(navController: UINavigationController) -> Coordinator & FavoritesOutputCoordinator
    func makeAddAnnouncementCoordinator(navController: UINavigationController) -> Coordinator & AddAnnouncementOutputCoordinator
    func makeProfileCoordinator(profileType: ProfileType, navController: UINavigationController) -> Coordinator & ProfileOutputCoordinator
    func makeProfileCoordinator(profileType: ProfileType, router: RouterProtocol) -> Coordinator & ProfileOutputCoordinator
    func makeSettingsCoordinator(router: RouterProtocol, coordinatorFactory: CoordinatorFactory) -> Coordinator & SettingsOutputCoordinator
    func makeEditProfileCoordinator(router: RouterProtocol) -> Coordinator & EditProfileOutputCoordinator
    func makeFriendsCoordinator(router: RouterProtocol, coordinatorFactory: CoordinatorFactory) -> Coordinator & FriendsOutputCoordinator
    func makePassCodeCoordinator(passcodeType: PassCodeType ,router: RouterProtocol) -> Coordinator & PassCodeOutputCoordinator
}
