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

extension FlowFactory: SplashScreenFlowFactory, AuthFlowFactory {
    func makeSplashScreen() -> SplashScreenViewController {
        let vc = SplashScreenViewController()
        return vc
    }
    
    func makeSignInView() -> LoginViewController {
        let vm = LoginViewModel()
        let vc = LoginViewController(viewModel: vm)
        return vc
    }
    
    func makeSignUpView() -> SignUpViewController {
        let vm = SignUpViewModel()
        let vc = SignUpViewController(viewModel: vm)
        return vc
    }
}
