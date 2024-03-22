//
//  SetPasswordView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 23.02.2024.
//

import UIKit
import SnapKit
import Combine

final class SetPasswordView: BaseView {

    // MARK: - Properties
    
    private let viewModel: SetPasswordViewModel
    private let isFirstTime: Bool
    
    // MARK: - UI
    
    private lazy var createPasswordLabel = InfoLabel(type: .createPassword)
    private lazy var passwordTextField = InputTextField(inputType: .password)
    private lazy var repeatPasswordLabel = InfoLabel(type: .repeatPassword)
    private lazy var repeatPasswordTextField = InputTextField(inputType: .password)
    
    private lazy var changePasswordButton = ProceedButton(type: .system).apply {
        $0.type = isFirstTime ? .signUp : .changePassword
        $0.addTarget(self, action: #selector(changePasswordButtonTapped), for: .touchUpInside)
    }
    
    private lazy var infoLabel = InfoLabel(type: .passwordContain)
    private lazy var passwordRequirementsLabel = InfoLabel(type: .passwordRequirements)
    
    // MARK: - Object Lifecycle
    
    init(viewModel: SetPasswordViewModel, isFirstTime: Bool) {
        self.viewModel = viewModel
        self.isFirstTime = isFirstTime
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        setupObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        passwordTextField.layer.cornerRadius = 8
        repeatPasswordTextField.layer.cornerRadius = 8
        changePasswordButton.layer.cornerRadius = changePasswordButton.frame.height / 2
    }
}

// MARK: - Setup Views

private extension SetPasswordView {
    func setupViews() {
        addSubviews(createPasswordLabel, passwordTextField, repeatPasswordLabel, repeatPasswordTextField,
                    changePasswordButton, infoLabel, passwordRequirementsLabel)
    }
        
    func setupConstraints() {
        createPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalToSuperview().inset(16)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(createPasswordLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        repeatPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(16)
        }
        
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        changePasswordButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        passwordRequirementsLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - Actions

private extension SetPasswordView {
    @objc func changePasswordButtonTapped() {
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height + 8
            changePasswordButton.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().inset(keyboardHeight)
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(50)
            }
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        changePasswordButton.snp.remakeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}
