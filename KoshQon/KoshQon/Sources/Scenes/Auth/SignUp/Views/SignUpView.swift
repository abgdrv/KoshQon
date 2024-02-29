//
//  SignUpView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 27.02.2024.
//

import UIKit
import SnapKit

final class SignUpView: BaseView {

    // MARK: - Properties
    
    // MARK: - UI
    
    private lazy var infoLabel = InfoLabel(type: .registerPhone)
    private lazy var phoneLabel = InfoLabel(type: .phone)
    private lazy var phoneTextField = InputTextField(inputType: .phone)
    
    private lazy var continueButton: ProceedButton = {
        let button = ProceedButton(type: .system)
        button.type = .continue
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Object Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        phoneTextField.layer.cornerRadius = 8
        continueButton.layer.cornerRadius = continueButton.frame.height / 2
    }
}

// MARK: - Setup

private extension SignUpView {
    func setupViews() {
        [infoLabel, phoneLabel, phoneTextField, continueButton].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(16)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
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

private extension SignUpView {
    @objc func continueButtonTapped() {
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height + 8
            continueButton.snp.remakeConstraints { make in
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
        continueButton.snp.remakeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}
