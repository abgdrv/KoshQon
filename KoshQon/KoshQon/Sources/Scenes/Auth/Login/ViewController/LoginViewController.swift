//
//  LoginViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.02.2024.
//

import UIKit

final class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didLogin: VoidCallback?
    var didForgot: VoidCallback?
    var didRegister: VoidCallback?
    
    private let viewModel: LoginViewModel
    
    // MARK: - UI
    
    private lazy var loginView = LoginView()
    
    // MARK: - Object Lifecycle
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
}

// MARK: - Setup

private extension LoginViewController {
    func setupBindings() {
        loginView.didForgot = { [weak self] in
            guard let self = self else { return }
            self.didForgot?()
        }
        
        loginView.didLogin = { [weak self] model in
            guard let self = self else { return }
            self.viewModel.login(loginModel: model)
            self.didLogin?()
        }
        
        loginView.didRegister = { [weak self] in
            guard let self = self else { return }
            self.didRegister?()
        }
    }
}
