//
//  SignInView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 21.02.2024.
//

import UIKit
import SnapKit

final class SignInView: BaseView {
    
    // MARK: - Properties
    
    private let viewModel: SignInViewModel

    // MARK: - UI
    
    private lazy var logoNameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.anta.s40
        label.textAlignment = .center
        label.textColor = AppColor.Theme.mainTitle.uiColor
        label.text = "KoshQon"
        return label
    }()
    
    private lazy var formView = UIView()
    private lazy var phoneLabel = InfoLabel(type: .phone)
    private lazy var phoneTextField = InputTextField(inputType: .phone)
    private lazy var passwordLabel = InfoLabel(type: .password)
    private lazy var passwordTextField = InputTextField(inputType: .password)
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Забыл пароль", for: .normal)
        button.titleLabel?.font = AppFont.regular.s14
        button.setTitleColor(AppColor.Static.darkBlue.uiColor, for: .normal)
        button.tintColor = .clear
        button.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var signInButton: ProceedButton = {
        let button = ProceedButton(type: .system)
        button.type = .signIn
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpLinkLabel: UILabel = {
        let label = UILabel()
        let regularText = "У вас нет аккаунта?"
        let linkText = "Зарегистрироваться"
        let linkString = NSMutableAttributedString(string: regularText + " " + linkText)
        linkString.addAttributes(
            [.foregroundColor: AppColor.Static.orange.uiColor, .underlineStyle: NSUnderlineStyle.single.rawValue],
            range: NSRange(location: regularText.count + 1, length: linkText.count))
        label.attributedText = linkString
        label.font = AppFont.regular.s16
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                          action: #selector(signUpLinkLabelTapped)))
        return label
    }()
    
    // MARK: - Object Lifecycle
    
    init(viewModel: SignInViewModel) {
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
        passwordTextField.layer.cornerRadius = 8
        signInButton.layer.cornerRadius = signInButton.frame.height / 2
    }
    
}

// MARK: - Setup Views, Constraints

private extension SignInView {
    func setupViews() {
        [logoNameLabel, formView].forEach { addSubview($0) }
        [phoneLabel, phoneTextField, passwordLabel, passwordTextField,
         forgotPasswordButton, signInButton, signUpLinkLabel].forEach { formView.addSubview($0) }
    }
    
    func setupConstraints() {
        logoNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(formView.snp.top).offset(-50)
            make.centerX.equalToSuperview()
        }
        
        formView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(16)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview()
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.trailing.equalToSuperview()
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        signUpLinkLabel.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
    }
}

// MARK: - Actions

private extension SignInView {
    @objc func forgotPasswordButtonTapped() {
    }
    
    @objc func signInButtonTapped() {
        
    }
    
    @objc func signUpLinkLabelTapped() {
    }
}
