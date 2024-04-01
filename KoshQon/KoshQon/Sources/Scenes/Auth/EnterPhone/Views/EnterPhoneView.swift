//
//  EnterPhoneView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 27.02.2024.
//

import UIKit
import SnapKit

enum EnterPhoneType: String {
    case registration
    case forgotPassword
    case changePhone
}

final class EnterPhoneView: BaseView {

    // MARK: - Properties
    
    var didFinish: VoidCallback?
    
    private let type: EnterPhoneType
    
    override var keyboardHandlingButton: ProceedButton? {
        continueButton
    }
    
    // MARK: - UI
    
    private lazy var infoLabel = InfoLabel(type: type == .registration ? .registerPhone : .forgotPassword)
    private lazy var phoneLabel = InfoLabel(type: .phone)
    private lazy var phoneTextField = InputTextField(inputType: .phone)
    
    private lazy var continueButton = ProceedButton(type: .system).apply {
        $0.type = .continue
        $0.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }

    // MARK: - Object Lifecycle
    
    init(type: EnterPhoneType) {
        self.type = type
        super.init()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        phoneTextField.layer.cornerRadius = 8
        continueButton.layer.cornerRadius = continueButton.frame.height / 2
    }
}

// MARK: - Setup

private extension EnterPhoneView {
    func setupViews() {
        addSubviews(infoLabel, phoneLabel, phoneTextField, continueButton)
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
}

// MARK: - Actions

private extension EnterPhoneView {
    @objc func continueButtonTapped() {
        didFinish?()
    }
}
