//
//  SetPasswordViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 23.02.2024.
//

import UIKit

final class SetPasswordViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didFinish: VoidCallback?
    
    private let viewModel: SetPasswordViewModel
    private let type: SetPasswordType
    
    // MARK: - UI
    
    private lazy var setPasswordView = SetPasswordView(type: type)
    
    // MARK: - Object Lifecycle
    
    init(viewModel: SetPasswordViewModel, type: SetPasswordType) {
        self.viewModel = viewModel
        self.type = type
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
        setupBindings()
    }
}

// MARK: - Setup

private extension SetPasswordViewController {
    func setupNavigation() {
        navigationItem.titleView = NavigationTitleView(type: .createPassword)
    }
    
    func setupBindings() {
        setPasswordView.didFinish = { [weak self] in
            guard let self = self else { return }
            self.didFinish?()
        }
    }
}
