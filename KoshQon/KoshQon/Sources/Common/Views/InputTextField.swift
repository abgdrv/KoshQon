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
    
    var didTap: Callback<InputType>?
    
    private let type: InputType
    private let placeHolder: String?
    
    private var padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 50)
    private var placeholderPadding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 50)
    
    // MARK: - UI
    
    private lazy var containerView = UIStackView()
    
    private lazy var hidePasswordButton = UIButton(type: .custom).apply {
        $0.setImage(AppImage.Auth.eyeOff.uiImage, for: .normal)
        $0.setImage(AppImage.Auth.eyeOn.uiImage, for: .selected)
        $0.addTarget(self, action: #selector(hidePasswordButtonTapped), for: .touchUpInside)
    }
    
    private lazy var iconImageView = UIImageView().apply { $0.contentMode = .center }
    
    // MARK: - Object Lifecycle
    
    init(inputType: InputType, placeHolder: String? = nil) {
        self.type = inputType
        self.placeHolder = placeHolder
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 1
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
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.clearButtonRect(forBounds: bounds)
        return originalRect.offsetBy(dx: -7.5, dy: 0)
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        setupViews()
        setupConstraints()
        setupPadding()
        setupGestures()
        setupClearButton()
        
        switch type {
        case .password:
            setup(placeholder: "Введите ваш пароль", isSecureTextEntry: true)
        case .date:
            setup(placeholder: "Дата рождения", image: AppImage.Auth.calendar.uiImage)
        case .phone:
            setup(placeholder: "Введите ваш номер телефона",
                  keyboardType: .phonePad, clearButtonMode: .whileEditing)
        case .gender:
            setup(placeholder: "Пол", image: AppImage.Auth.expandDown.uiImage)
        case .city:
            setup(placeholder: "Город", image: AppImage.Auth.expandDown.uiImage)
        case .sms:
            setup(keyboardType: .numberPad, font: AppFont.bold.s24,
                  borderColor: AppColor.Static.orange.cgColor, textAlignment: .center)
        case .regular:
            setup(placeholder: placeHolder, clearButtonMode: .whileEditing)
        }
    }
    
    private func setup(placeholder: String? = nil,
                       keyboardType: UIKeyboardType = .default,
                       font: UIFont = AppFont.medium.s16,
                       isSecureTextEntry: Bool = false,
                       clearButtonMode: UITextField.ViewMode = .never,
                       borderColor: CGColor = AppColor.Static.lightGray.cgColor,
                       textColor: UIColor = AppColor.Static.darkGray.uiColor,
                       backgroundColor: UIColor = AppColor.Theme.mainBackground.uiColor,
                       textAlignment: NSTextAlignment = .natural,
                       isEnabled: Bool = true,
                       image: UIImage? = nil) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.font = font
        self.isSecureTextEntry = isSecureTextEntry
        self.clearButtonMode = clearButtonMode
        self.layer.borderColor = borderColor
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.textAlignment = textAlignment
        self.isEnabled = isEnabled
        iconImageView.image = image
        delegate = self
    }
}

// MARK: - Setup Views

private extension InputTextField {
    func setupViews() {
        addSubviews(containerView)
        switch type {
        case .password:
            containerView.addArrangedSubview(hidePasswordButton)
        case .phone:
            break
        case .gender,.city, .date:
            containerView.addArrangedSubview(iconImageView)
        case .regular, .sms:
            break
        }
    }
    
    func setupConstraints() {
        switch type {
        case .password, .date, .gender, .city:
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
        default:
            break
        }
    }
    
    func setupGestures() {
        switch type {
        case .phone:
            containerView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                      action: #selector(phonePickerTapped)))
        case .gender, .city:
            addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(someTextFieldTapped)))
        default:
            break
        }
    }
    
    func setupClearButton() {
        if let clearButton = value(forKeyPath: "_clearButton") as? UIButton {
            clearButton.setImage(AppImage.Auth.clear.uiImage, for: .normal)
        }
    }
}

// MARK: - Private methods

private extension InputTextField {
    func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "(###) ### ## ##"
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "#" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

// MARK: - Actions

private extension InputTextField {
    @objc func hidePasswordButtonTapped() {
        isSecureTextEntry.toggle()
        hidePasswordButton.isSelected.toggle()
    }
    
    @objc func someTextFieldTapped() {
        didTap?(type)
    }
    
    @objc func phonePickerTapped() {
        didTap?(.phone)
    }
}

extension InputTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        switch type {
        case .password, .regular:
            return true
        case .phone:
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = formattedNumber(number: newString)
            return false
        case .sms:
            let maxLength = 1
            let newText = (text as NSString).replacingCharacters(in: range, with: string)
            return newText.count <= maxLength
        default:
            return false
        }
    }
}
