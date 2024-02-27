//
//  InputTextField.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.02.2024.
//

import UIKit
import SnapKit

enum InputType {
    case password
    case date
    case phone
    case gender
    case city
    case regular
    case sms
}

final class InputTextField: UITextField {
    
    // MARK: - Properties
    
    private var padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    private var placeholderPadding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    private let type: InputType
    private let inputData: [String]? = []
    
    // MARK: - UI
    
    private lazy var containerView = UIStackView()
    
    private lazy var hidePasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(AppImage.Auth.eyeOff.uiImage, for: .normal)
        button.setImage(AppImage.Auth.eyeOn.uiImage, for: .selected)
        button.addTarget(self, action: #selector(hidePasswordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var clearContentButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(AppImage.Auth.clear.uiImage, for: .normal)
        button.addTarget(self, action: #selector(clearContentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var calendarButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(AppImage.Auth.calendar.uiImage, for: .normal)
        return button
    }()
    
    private lazy var expandDownButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(AppImage.Auth.expandDown.uiImage, for: .normal)
        return button
    }()
    
    // MARK: - Object Lifecycle
    
    init(inputType: InputType) {
        self.type = inputType
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch type {
        case .password:
            break
        case .date:
            break
        case .phone:
            break
        case .gender:
            break
        case .city:
            break
        case .regular:
            checkEditing()
        case .sms:
            break
        }
    }
    
    // MARK: - Override Functions
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: placeholderPadding)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        font = AppFont.medium.s16
        textColor = AppColor.Static.darkGray.uiColor
        backgroundColor = AppColor.Theme.mainBackground.uiColor
        layer.borderColor = AppColor.Static.darkGray.cgColor
        layer.borderWidth = 1
        clipsToBounds = true
        autocapitalizationType = .none
        autocorrectionType = .no
        spellCheckingType = .no
        
        setupViews()
        setupConstraints()
        setupPadding()
        
        switch type {
        case .password:
            isSecureTextEntry = true
            placeholder = "Введите ваш пароль"
        case .date:
            placeholder = "Дата рождения"
        case .phone:
            placeholder = "Введите ваш номер телефона"
            keyboardType = .phonePad
        case .gender:
            placeholder = "Пол"
        case .city:
            placeholder = "Город"
        case .sms:
            keyboardType = .numberPad
            font = AppFont.bold.s24
            layer.borderColor = AppColor.Static.orange.cgColor
            textAlignment = .center
        case .regular:
            break
        }
    }
    
    private func checkEditing() {
        if isEditing && text?.isEmpty == false {
            clearContentButton.isHidden = false
        } else {
            clearContentButton.isHidden = true
        }
    }
}

// MARK: - Setup Views

private extension InputTextField {
    func setupViews() {
        addSubview(containerView)
        switch type {
        case .password:
            containerView.addArrangedSubview(hidePasswordButton)
        case .date:
            containerView.addArrangedSubview(calendarButton)
        case .phone:
            break
        case .gender,.city:
            containerView.addArrangedSubview(expandDownButton)
        case .regular, .sms:
            break
        }
    }
    
    func setupConstraints() {
        switch type {
        case .password:
            containerView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.trailing.equalToSuperview()
                make.width.equalTo(50)
            }
        case .phone:
            containerView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.leading.equalToSuperview()
                make.width.equalTo(50)
            }
        case .regular:
            break
        default:
            break
        }
        
    }
    
    func setupPadding() {
        switch type {
        case .password, .date, .gender, .city:
            padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 60)
            placeholderPadding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 60)
        case .phone:
            padding = UIEdgeInsets(top: 16, left: 60, bottom: 16, right: 16)
            placeholderPadding = UIEdgeInsets(top: 16, left: 60, bottom: 16, right: 16)
        case .regular, .sms:
            break
        }
    }
    
    func setupGestures() {
        
    }
}

// MARK: - Actions

private extension InputTextField {
    @objc func hidePasswordButtonTapped() {
        isSecureTextEntry.toggle()
        hidePasswordButton.isSelected.toggle()
    }
    
    @objc func clearContentButtonTapped() {
        text = ""
        clearContentButton.isHidden = true
    }
    
    @objc func calendarButtonTapped() {
        
    }
    
    @objc func expandDownButtonTapped() {
        
    }
}
