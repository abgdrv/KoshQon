//
//  ForgotPasswordView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.02.2024.
//

import UIKit
import SnapKit

final class ForgotPasswordView: BaseView {

    // MARK: - Properties
    
    private let viewModel: ForgotPasswordViewModel
    var onAction: Callback<String>?
    
    // MARK: - UI
    
    private lazy var phoneLabel = InputLabel(type: .phone)
    private lazy var phoneTextField = InputTextField(inputType: .phone)
    
    private lazy var continueButton: ProceedButton = {
        let button = ProceedButton(type: .system)
        button.type = .continue
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Object Lifecycle
    
    init(viewModel: ForgotPasswordViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        phoneTextField.layer.cornerRadius = 8
        continueButton.layer.cornerRadius = continueButton.frame.height / 2
    }
}

// MARK: - Setup Views, Constraints

private extension ForgotPasswordView {
    func setupViews() {
        [phoneLabel, phoneTextField, continueButton].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalToSuperview().offset(16)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}

// MARK: - Actions

private extension ForgotPasswordView {
    @objc func continueButtonTapped() {
        onAction?(phoneTextField.text ?? "")
    }
}
