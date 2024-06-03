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
    func makeTabBarCoordinator(isFirst: Bool, router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol) -> Coordinator & TabBarOutputCoordinator
    func makeMainScreenCoordinator(isFirst: Bool, navController: UINavigationController) -> Coordinator & MainScreenOutputCoordinator
    func makeFavoritesCoordinator(navController: UINavigationController) -> Coordinator & AnnouncementsOutputCoordinator
    func makeAddAnnouncementCoordinator(navController: UINavigationController) -> Coordinator & AddAnnouncementOutputCoordinator
    func makeProfileCoordinator(user: User, profileType: ProfileType, navController: UINavigationController) -> Coordinator & ProfileOutputCoordinator
    func makeProfileCoordinator(user: User, profileType: ProfileType, router: RouterProtocol) -> Coordinator & ProfileOutputCoordinator
    func makeSettingsCoordinator(router: RouterProtocol, coordinatorFactory: CoordinatorFactory) -> Coordinator & SettingsOutputCoordinator
    func makeEditProfileCoordinator(router: RouterProtocol) -> Coordinator & EditProfileOutputCoordinator
    func makeFriendsCoordinator(router: RouterProtocol, coordinatorFactory: CoordinatorFactory) -> Coordinator & FriendsOutputCoordinator
    func makePassCodeCoordinator(passcodeType: PassCodeType ,router: RouterProtocol) -> Coordinator & PassCodeOutputCoordinator
    func makeMessagesCoordinator(navController: UINavigationController) -> Coordinator & MessagesOutputCoordinator
    func makeAnnouncementDetailsCoordinator(announcement: Announcement, router: RouterProtocol) -> Coordinator & AnnouncementDetailsOutputCoordinator
}
