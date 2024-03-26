//
//  FlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.03.2024.
//

import Foundation
import UIKit

final class FlowFactory {
    
    // MARK: - Properties
    
    static let shared = FlowFactory()
    
    // MARK: - Object Lifecycle
    
    private init() {}
}

extension FlowFactory: AlertFlowFactory,
                       SplashScreenFlowFactory,
                       AuthFlowFactory,
                       RegisterFlowFactory,
                       TabBarFlowFactory,
                       MainScreenFlowFactory,
                       FavoritesFlowFactory,
                       AddAnnouncementFlowFactory,
                       ProfileFlowFactory {
    func makeAlert(title: String, message: String, with actions: [UIAlertAction]) -> UIAlertController {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach {
            ac.addAction($0)
        }
        return ac
    }
    
    func makeAlertSheet(title: String, message: String, with actions: [UIAlertAction]) -> UIAlertController {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach {
            ac.addAction($0)
        }
        return ac
    }
    
    func makeSplashScreen() -> SplashScreenViewController {
        let vc = SplashScreenViewController()
        return vc
    }
    
    func makeLoginView() -> LoginViewController {
        let vm = LoginViewModel()
        let vc = LoginViewController(viewModel: vm)
        return vc
    }
    
    func makeEnterPhoneView(type: EnterPhoneType) -> EnterPhoneViewController {
        let vm = EnterPhoneViewModel(type: type)
        let vc = EnterPhoneViewController(viewModel: vm, type: type)
        return vc
    }
    
    func makeSmsCodeView() -> SmsCodeViewController {
        let vm = SmsCodeViewModel()
        let vc = SmsCodeViewController(viewModel: vm)
        return vc
    }
    
    func makePersonalView() -> PersonalViewController {
        let vm = PersonalViewModel()
        let vc = PersonalViewController(viewModel: vm)
        return vc
    }
    
    func makeSetPasswordView(type: SetPasswordType) -> SetPasswordViewController {
        let vm = SetPasswordViewModel(type: type)
        let vc = SetPasswordViewController(viewModel: vm, type: type)
        return vc
    }
    
    func makeTabBarView() -> TabBarController {
        let vm = TabBarViewModel()
        let vc = TabBarController(viewModel: vm)
        return vc
    }
    
    func makeMainScreenView() -> MainScreenViewController {
        let vm = MainScreenViewModel()
        let vc = MainScreenViewController(viewModel: vm)
        return vc
    }
    
    func makeFavoritesView(type: AnnouncementsType) -> AnnouncementsViewController {
        let vm = AnnouncementsViewModel(type: type)
        let vc = AnnouncementsViewController(viewModel: vm, type: type)
        return vc
    }
    
    func makeAddAnnouncementView() -> AddAnnouncementViewController {
        let vm = AddAnnouncementViewModel()
        let vc = AddAnnouncementViewController(viewModel: vm)
        return vc
    }
    
    func makeProfileView() -> ProfileViewController {
        let vm = ProfileViewModel()
        let vc = ProfileViewController(viewModel: vm)
        return vc
    }
}
