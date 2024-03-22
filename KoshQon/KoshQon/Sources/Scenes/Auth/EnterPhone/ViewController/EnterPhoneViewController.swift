//
//  EnterPhoneViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 27.02.2024.
//

import UIKit

final class EnterPhoneViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didFinish: VoidCallback?
    
    private let viewModel: EnterPhoneViewModel
    private let type: EnterPhoneType
    
    // MARK: - UI
    
    private lazy var enterPhoneView = EnterPhoneView(type: type)
    
    // MARK: - Object Lifecycle
    
    init(viewModel: EnterPhoneViewModel, type: EnterPhoneType) {
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
        view = enterPhoneView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupBindings()
    }
}

// MARK: - Setup

private extension EnterPhoneViewController {
    func setupNavigation() {
        navigationItem.titleView = NavigationTitleView(type: type == .register
                                                       ? .registration
                                                       : .forgotPassword)
    }
    
    func setupBindings() {
        enterPhoneView.didFinish = { [weak self] in
            guard let self = self else { return }
            self.didFinish?()
        }
    }
}
