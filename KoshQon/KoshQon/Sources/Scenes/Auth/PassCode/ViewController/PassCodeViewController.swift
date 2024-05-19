//
//  PassCodeViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.04.2024.
//

import SwiftUI
import SnapKit

class PassCodeViewController: BaseViewController {
    
    // MARK: - Properties
    
    var passcodeDidEnter: Callback<Bool>?
    
    private let viewModel: PassCodeViewModel
    
    // MARK: - UI
    
    private lazy var passcodeView = PassCodeView(viewModel: viewModel)
    private lazy var hostingController = UIHostingController(rootView: passcodeView)
    private lazy var passCodeView = hostingController.view ?? UIView()
    
    // MARK: - Object Lifecycle
    
    init(viewModel: PassCodeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}

// MARK: - Setup Views

private extension PassCodeViewController {
    func setupViews() {
        view.addSubview(passCodeView)
    }
        
    func setupConstraints() {
        passCodeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupBindings() {
        passcodeView.passwordDidEnter = { [weak self] isVerify in
            guard let self = self else { return }
            self.passcodeDidEnter?(isVerify)
        }
    }
}

