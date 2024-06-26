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
    
    private var code: String = "+7"
    
    // MARK: - UI
    
    private lazy var appNameLabel = UILabel().apply {
        $0.set(font: AppFont.anta.s40, textColor: AppColor.Theme.mainTitle.uiColor)
        $0.textAlignment = .center
        $0.text = Constants.App.name
    }
    
    private lazy var formView = UIView()
    private lazy var phoneLabel = InfoLabel(type: .phone)
    private lazy var phoneTextField = InputTextField(inputType: .phone)
    private lazy var passwordLabel = InfoLabel(type: .password)
    private lazy var passwordTextField = InputTextField(inputType: .password)
    
    private lazy var forgotPasswordButton = UIButton(type: .system).apply {
        $0.setTitle("Забыл пароль", for: .normal)
        $0.set(font: AppFont.regular.s14, titleColor: AppColor.Static.darkBlue.uiColor)
        $0.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
    }
    
    private lazy var loginButton = ProceedButton(type: .system).apply {
        $0.type = .signIn
        $0.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private lazy var registerLabel = InfoLabel(type: .noAccount)
    
    private lazy var registerButton = UIButton(type: .system).apply {
        $0.set(font: AppFont.regular.s16, titleColor: AppColor.Static.orange.uiColor)
        $0.contentHorizontalAlignment = .left
        let title = NSMutableAttributedString(string: "Зарегистрироваться")
        title.addAttributes([.underlineStyle: NSUnderlineStyle.single.rawValue],
                            range: NSRange(location: 0, length: title.length))
        $0.setAttributedTitle(title, for: .normal)
        $0.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    private lazy var registerContainerView = UIStackView(arrangedSubviews: [registerLabel,
                                                                            registerButton]).apply {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.distribution = .fillEqually
    }
    
    // MARK: - Object Lifecycle
    
    override init() {
        super.init()
        setupViews()
        setupConstraints()
        setupBindings()
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        phoneTextField.layer.cornerRadius = 8
        passwordTextField.layer.cornerRadius = 8
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
    }
    
}

// MARK: - Setup Views

private extension LoginView {
    func setupViews() {
        addSubviews(appNameLabel, formView)
        formView.addSubviews(phoneLabel, phoneTextField, passwordLabel, passwordTextField,
                             forgotPasswordButton, loginButton, registerContainerView)
    }
    
    func setupConstraints() {
        appNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.33)
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
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        registerContainerView.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    func setupBindings() {
        phoneTextField.didPhoneCodeSelect = { [weak self] code in
            guard let self = self else { return }
            self.code = code
        }
    }
}

// MARK: - Actions

private extension LoginView {
    @objc func forgotPasswordButtonTapped() {
        didForgot?()
    }
    
    @objc func registerButtonTapped() {
        didRegister?()
    }
    
    @objc func loginButtonTapped() {
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
        
        didLogin?(LoginModel(code: code, phoneNumber: phoneNumber, password: password))
    }
}
