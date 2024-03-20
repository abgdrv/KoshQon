//
//  SignInViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.02.2024.
//

import UIKit

final class SignInViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didSignIn: VoidCallback?
    var didForgot: VoidCallback?
    var didSignUp: VoidCallback?
    
    private let viewModel: SignInViewModel
    
    // MARK: - UI
    
    private lazy var signInView = SignInView()
    
    // MARK: - Object Lifecycle
    
    init(viewModel: SignInViewModel) {
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

private extension SignInViewController {
    func setupBindings() {
        signInView.didSignIn = { [weak self] model in
            guard let self = self else { return }
            self.viewModel.signIn(signInModel: model)
        }
    }
}
