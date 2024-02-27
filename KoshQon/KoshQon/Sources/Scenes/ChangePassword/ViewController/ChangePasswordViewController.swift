//
//  ChangePasswordViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 23.02.2024.
//

import UIKit

final class ChangePasswordViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let viewModel: ChangePasswordViewModel
    
    // MARK: - UI
    
    private lazy var changePasswordView = ChangePasswordView(viewModel: viewModel, isFirstTime: false)
    
    // MARK: - Object Lifecycle
    
    init(viewModel: ChangePasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = changePasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
}

// MARK: - Setup Navigation

private extension ChangePasswordViewController {
    func setupNavigation() {
        let navigationTitle = NavigationTitleView(type: .createPassword)
        navigationItem.titleView = navigationTitle
    }
}
