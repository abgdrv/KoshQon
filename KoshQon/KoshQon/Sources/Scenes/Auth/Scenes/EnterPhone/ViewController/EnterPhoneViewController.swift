//
//  EnterPhoneViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 27.02.2024.
//

import UIKit

final class EnterPhoneViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let viewModel: EnterPhoneViewModel
    private let isFirst: Bool
    
    // MARK: - UI
    
    private lazy var enterPhoneView = EnterPhoneView(isFirst: isFirst)
    
    // MARK: - Object Lifecycle
    
    init(viewModel: EnterPhoneViewModel, isFirst: Bool) {
        self.viewModel = viewModel
        self.isFirst = isFirst
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
    }
}

// MARK: - Navigation

private extension EnterPhoneViewController {
    func setupNavigation() {
        navigationItem.titleView = NavigationTitleView(type: isFirst ? .registration : .forgotPassword)
    }
}
