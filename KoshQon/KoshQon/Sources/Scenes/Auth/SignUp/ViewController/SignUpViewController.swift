//
//  SignUpViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 27.02.2024.
//

import UIKit

final class SignUpViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let viewModel: SignUpViewModel
    
    // MARK: - UI
    
    private lazy var signUpView = SignUpView(viewModel: viewModel)
    
    // MARK: - Object Lifecycle
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

// MARK: - Navigation

private extension SignUpViewController {
    func setupNavigation() {
        navigationItem.titleView = NavigationTitleView(type: .registration, isIcon: true)
    }
}
