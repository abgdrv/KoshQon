//
//  FlowFactory.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.03.2024.
//

import Foundation

final class FlowFactory {
    
    // MARK: - Properties
    
    static let shared = FlowFactory()
    
    // MARK: - Object Lifecycle
    
    private init() {}
}

extension FlowFactory: SplashScreenFlowFactory,
                       AuthFlowFactory,
                       RegisterFlowFactory {
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
}
