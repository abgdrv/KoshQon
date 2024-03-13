//
//  SmsCodeViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.02.2024.
//

import UIKit

final class SmsCodeViewController: BaseViewController {
    
    // MARK: - Properties
    
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
        smsCodeView.onAction = {
            self.navigationController?.pushViewController(ChangePasswordViewController(viewModel: ChangePasswordViewModel()), animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
}

// MARK: - Navigation

private extension SmsCodeViewController {
    func setupNavigation() {
        navigationItem.titleView = NavigationTitleView(type: .sms)
    }
}
