//
//  LoginView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 21.02.2024.
//

import UIKit
import SnapKit
import ProgressHUD

final class LoginView: BaseView {
    
    // MARK: - Properties
    
    var didForgot: VoidCallback?
    var didRegister: VoidCallback?
    var didLogin: Callback<LoginModel>?
    
    // MARK: - UI
    
    private lazy var logoNameLabel = UILabel().apply {
        $0.font = AppFont.anta.s40
        $0.textAlignment = .center
        $0.textColor = AppColor.Theme.mainTitle.uiColor
        $0.text = "KoshQon"
    }
    
    private lazy var formView = UIView()
    private lazy var phoneLabel = InfoLabel(type: .phone)
    private lazy var phoneTextField = InputTextField(inputType: .phone)
    private lazy var passwordLabel = InfoLabel(type: .password)
    private lazy var passwordTextField = InputTextField(inputType: .password)
    
    private lazy var forgotPasswordButton = UIButton(type: .system).apply {
        $0.setTitle("Забыл пароль", for: .normal)
        $0.titleLabel?.font = AppFont.regular.s14
        $0.setTitleColor(AppColor.Static.darkBlue.uiColor, for: .normal)
        $0.tintColor = .clear
        $0.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
    }
    
    private lazy var signInButton = ProceedButton(type: .system).apply {
        $0.type = .signIn
        $0.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    private lazy var signUpLinkLabel = UILabel().apply {
        let regularText = "У вас нет аккаунта?"
        let linkText = "Зарегистрироваться"
        let linkString = NSMutableAttributedString(string: regularText + " " + linkText)
        linkString.addAttributes([.foregroundColor: AppColor.Static.orange.uiColor,
                                  .underlineStyle: NSUnderlineStyle.single.rawValue],
                                 range: NSRange(location: regularText.count + 1, length: linkText.count))
        $0.attributedText = linkString
        $0.font = AppFont.regular.s16
        $0.textAlignment = .center
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(signUpLinkLabelTapped)))
    }
    
    // MARK: - Object Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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

// MARK: - Setup Views

private extension LoginView {
    func setupViews() {
        addSubviews(logoNameLabel, formView)
        formView.addSubviews(phoneLabel, phoneTextField, passwordLabel, passwordTextField,
                             forgotPasswordButton, signInButton, signUpLinkLabel)
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

private extension LoginView {
    @objc func forgotPasswordButtonTapped() {
        didForgot?()
    }
    
    @objc func signInButtonTapped() {
        guard let phoneNumber = phoneTextField.text, !phoneNumber.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            ProgressHUD.banner("Ошибка!", "Некоторые из полей пустые!", delay: 3)
            return
        }
        
        if phoneNumber.count < 10 {
            ProgressHUD.banner("Ошибка!", "Неккоректный номер телефона!", delay: 3)
            return
        }
        
        if password.count < 8 {
            ProgressHUD.banner("Ошибка!", "Неккоректный пароль!", delay: 3)
            return
        }
        
        didLogin?(LoginModel(phoneNumber: phoneNumber, password: password))
    }
    
    @objc func signUpLinkLabelTapped() {
    }
}
