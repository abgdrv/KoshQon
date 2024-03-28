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
    
    override var navigationTitleType: NavigationTitleType? {
        return .sms
    }
    
    // MARK: - UI
    
    private lazy var smsCodeView = SmsCodeView(viewModel: viewModel)
    
    // MARK: - Object Lifecycle
    
    init(viewModel: SmsCodeViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = smsCodeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
}

// MARK: - Setup

private extension SmsCodeViewController {
    func setupBindings() {
        smsCodeView.didFinish = { [weak self] in
            guard let self = self else { return }
            self.didFinish?()
        }
    }
}
