//
//  SmsCodeViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.02.2024.
//

import UIKit

final class SmsCodeViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didFinish: VoidCallback?
    
    private let viewModel: SmsCodeViewModel
    
    // MARK: - UI
    
    private lazy var smsCodeView = SmsCodeView(viewModel: viewModel)
    
    // MARK: - Object Lifecycle
    
    init(viewModel: SmsCodeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = smsCodeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupBindings()
    }
}

// MARK: - Setup

private extension SmsCodeViewController {
    func setupNavigation() {
        navigationItem.titleView = NavigationTitleView(type: .sms)
    }
    
    func setupBindings() {
        smsCodeView.didFinish = { [weak self] in
            guard let self = self else { return }
            self.didFinish?()
        }
    }
}
