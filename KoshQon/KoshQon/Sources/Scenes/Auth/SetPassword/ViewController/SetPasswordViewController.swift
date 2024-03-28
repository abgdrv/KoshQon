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
    
    override var navigationTitleType: NavigationTitleType? {
        return .createPassword
    }
    
    // MARK: - UI
    
    private lazy var setPasswordView = SetPasswordView(type: type)
    
    // MARK: - Object Lifecycle
    
    init(viewModel: SetPasswordViewModel, type: SetPasswordType) {
        self.viewModel = viewModel
        self.type = type
        super.init()
    }

    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = setPasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
}

// MARK: - Setup

private extension SetPasswordViewController {
    func setupBindings() {
        setPasswordView.didFinish = { [weak self] in
            guard let self = self else { return }
            self.didFinish?()
        }
    }
}
