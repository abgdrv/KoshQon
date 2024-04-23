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
    
    private let viewModel: PassCodeViewModel
    
    // MARK: - UI
    
    private lazy var hostingController = UIHostingController(rootView: PassCodeView(viewModel: viewModel))
    private lazy var passCodeView = hostingController.view ?? UIView()
    
    // MARK: - Object Lifecycle
    
    init(viewModel: PassCodeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
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
}

