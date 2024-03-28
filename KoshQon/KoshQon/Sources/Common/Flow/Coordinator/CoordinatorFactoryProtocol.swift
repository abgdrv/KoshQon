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
    func makeRegisterCoordinator(router: RouterProtocol) -> Coordinator & RegisterOutputCoordinator
    func makeForgotPasswordCoordinator(router: RouterProtocol) -> Coordinator & ForgotPasswordOutputCoordinator
    func makeTabBarCoordinator(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol) -> Coordinator & TabBarOutputCoordinator
    func makeMainScreenCoordinator(navController: UINavigationController) -> Coordinator & MainScreenOutputCoordinator
    func makeFavoritesCoordinator(navController: UINavigationController) -> Coordinator & FavoritesOutputCoordinator
    func makeAddAnnouncementCoordinator(navController: UINavigationController) -> Coordinator & AddAnnouncementOutputCoordinator
    func makeProfileCoordinator(navController: UINavigationController) -> Coordinator & ProfileOutputCoordinator
    func makeSettingsCoordinator(router: RouterProtocol) -> Coordinator & SettingsOutputCoordinator
    func makeEditProfileCoordinator(router: RouterProtocol) -> Coordinator & EditProfileOutputCoordinator
}
