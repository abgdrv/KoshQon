//
//  ForgotPasswordViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.02.2024.
//

import UIKit

final class ForgotPasswordViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: ForgotPasswordViewModel
    
    // MARK: - UI
    
    private lazy var forgotPasswordView = ForgotPasswordView(viewModel: viewModel)
    
    // MARK: - Object Lifecycle
    
    init(viewModel: ForgotPasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = forgotPasswordView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension ForgotPasswordViewController {
    func setupNavigation() {
        
    }
}
