//
//  LoginViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.02.2024.
//

import UIKit

final class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didSignIn: VoidCallback?
    var didForgot: VoidCallback?
    var didSignUp: VoidCallback?
    
    private let viewModel: LoginViewModel
    
    // MARK: - UI
    
    private lazy var signInView = LoginView()
    
    // MARK: - Object Lifecycle
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = signInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
}

// MARK: - Setup

private extension LoginViewController {
    func setupBindings() {
        signInView.didLogin = { [weak self] model in
            guard let self = self else { return }
            self.viewModel.signIn(signInModel: model)
        }
    }
}
