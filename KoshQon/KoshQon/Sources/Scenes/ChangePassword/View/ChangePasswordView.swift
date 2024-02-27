//
//  ChangePasswordView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 23.02.2024.
//

import UIKit
import SnapKit
import Combine

final class ChangePasswordView: BaseView {

    // MARK: - Properties
    
    private let viewModel: ChangePasswordViewModel
    private let isFirstTime: Bool
//    
//    static var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
//        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
//            .map { $0.(userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0 }
//
//        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
//            .map { _ in CGFloat(0) }
//
//        return MergeMany(willShow, willHide)
//            .eraseToAnyPublisher()
//    }
    
    // MARK: - UI
    
    private lazy var createPasswordLabel = InputLabel(type: .createPassword)
    private lazy var passwordTextField = InputTextField(inputType: .password)
    private lazy var repeatPasswordLabel = InputLabel(type: .repeatPassword)
    private lazy var repeatPasswordTextField = InputTextField(inputType: .password)
    
    private lazy var changePasswordButton: ProceedButton = {
        let button = ProceedButton(type: .system)
        button.type = isFirstTime ? .signUp : .changePassword
        button.addTarget(self, action: #selector(changePasswordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Object Lifecycle
    
    init(viewModel: ChangePasswordViewModel, isFirstTime: Bool) {
        self.viewModel = viewModel
        self.isFirstTime = isFirstTime
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
        passwordTextField.layer.cornerRadius = 8
        repeatPasswordTextField.layer.cornerRadius = 8
        changePasswordButton.layer.cornerRadius = changePasswordButton.frame.height / 2
    }
}

// MARK: - Setup Views, Constraints, Gestures

private extension ChangePasswordView {
    func setupViews() {
        [createPasswordLabel, passwordTextField, repeatPasswordLabel,
         repeatPasswordTextField, changePasswordButton].forEach { addSubview($0) }
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
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    func trackKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - Actions

private extension ChangePasswordView {
    @objc func changePasswordButtonTapped() {
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if frame.origin.y == 0 {
                frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if frame.origin.y != 0 {
            frame.origin.y = 0
        }
    }
}
