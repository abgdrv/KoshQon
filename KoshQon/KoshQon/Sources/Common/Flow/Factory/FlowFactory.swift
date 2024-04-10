//
//  FlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.03.2024.
//

import Foundation
import UIKit
import ProgressHUD

final class FlowFactory: AlertFlowFactory {
    
    func makeAlert(title: String?, message: String?, with actions: [UIAlertAction]) -> UIAlertController {
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
    
    func showBanner(title: String?, message: String?, delay: TimeInterval) {
        ProgressHUD.banner(title, message, delay: delay)
    }
    
}

extension FlowFactory: SplashScreenFlowFactory,
                       AuthFlowFactory,
                       EnterPhoneFlowFactory,
                       TabBarFlowFactory,
                       MainScreenFlowFactory,
                       FavoritesFlowFactory,
                       AddAnnouncementFlowFactory,
                       ProfileFlowFactory,
                       SettingsFlowFactory,
                       EditProfileFlowFactory,
                       FriendsFlowFactory {
    
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
    
    func makeImageZoomView(image: UIImage?) -> ImageDetailViewController {
        let vc = ImageDetailViewController(image: image)
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
    
    func makeSettingsView() -> SettingsViewController {
        let vm = SettingsViewModel(type: .settings)
        let vc = SettingsViewController(viewModel: vm)
        return vc
    }
    
    func makePrivacyView() -> PrivacyViewController {
        let vm = SettingsViewModel(type: .privacy)
        let vc = PrivacyViewController(viewModel: vm)
        return vc
    }
    
    func makeThemeView() -> ThemeViewController {
        let vm = SettingsViewModel(type: .theme)
        let vc = ThemeViewController(viewModel: vm)
        return vc
    }
    
    func makeEditProfileView(profile: Profile) -> EditProfileViewController {
        let vm = EditProfileViewModel(profile: profile)
        let vc = EditProfileViewController(viewModel: vm)
        return vc
    }
    
    func makeAboutMeView(existingText: String?) -> ProfileAboutMeViewController {
        let vc = ProfileAboutMeViewController(existingText: existingText)
        return vc
    }
    
    func makeCharacteristicsView(enabledChars: [CharacteristicType]) -> ProfileCharacteristicsViewController {
        let vc = ProfileCharacteristicsViewController(enabledChars: enabledChars)
        return vc
    }
    
    func makeFriendsView() -> FriendsViewController {
        let vm = FriendsViewModel()
        let vc = FriendsViewController(viewModel: vm)
        return vc
    }
}
