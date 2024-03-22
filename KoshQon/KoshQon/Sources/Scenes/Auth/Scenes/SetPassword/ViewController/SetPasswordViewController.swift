//
//  SetPasswordViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 23.02.2024.
//

import UIKit

final class SetPasswordViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let viewModel: SetPasswordViewModel
    
    // MARK: - UI
    
    private lazy var setPasswordView = SetPasswordView(viewModel: viewModel, isFirstTime: false)
    
    // MARK: - Object Lifecycle
    
    init(viewModel: SetPasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = setPasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
}

// MARK: - Navigation

private extension SetPasswordViewController {
    func setupNavigation() {
        navigationItem.titleView = NavigationTitleView(type: .createPassword)
    }
}