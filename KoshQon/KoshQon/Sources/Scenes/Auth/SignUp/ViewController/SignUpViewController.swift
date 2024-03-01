//
//  SignUpViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 27.02.2024.
//

import UIKit

final class SignUpViewController: BaseViewController {
    
    // MARK: - Properties
    
    // MARK: - UI
    
    private lazy var signUpView = SignUpView()
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = signUpView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
}

// MARK: - Setup Navigation

private extension SignUpViewController {
    func setupNavigation() {
        navigationItem.titleView = NavigationTitleView(type: .registration)
    }
}
