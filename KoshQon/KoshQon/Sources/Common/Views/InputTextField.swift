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
    case country
    case regular
    case sms
    case detailDate
    
    var menuType: MenuType? {
        switch self {
        case .phone:
            return MenuType.phone
        case .gender:
            return MenuType.gender
        case .city:
            return MenuType.city
        case .country:
            return MenuType.country
        default:
            return nil
        }
    }
}

final class InputTextField: UITextField {
    
    // MARK: - Properties
    
    var didCountrySelect: VoidCallback?
    var didPhoneCodeSelect: Callback<String>?
    
    private let type: InputType
    private let _placeholder: String?
    private let color = AppColor.Theme.separation.uiColor
    
    private var padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    private var placeholderPadding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    // MARK: - UI
    
    private lazy var containerView = UIStackView()
    private lazy var menuContainer = UIStackView()
    
    private lazy var hidePasswordButton = UIButton(type: .custom).apply {
        $0.setImage(AppImage.Auth.eyeOn.uiImage?.withTintColor(color), for: .normal)
        $0.setImage(AppImage.Auth.eyeOff.uiImage?.withTintColor(color), for: .selected)
        $0.addTarget(self, action: #selector(hidePasswordButtonTapped), for: .touchUpInside)
    }
    
    private lazy var iconImageView = UIImageView().apply { $0.contentMode = .center }
    private lazy var menuButton = MenuButton(type: .custom).apply {  $0.menuType = type.menuType }
    
    private lazy var toolbar = UIToolbar(
        frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
    ).apply {
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped)
        )
        let flexible = UIBarButtonItem(systemItem: .flexibleSpace)
        $0.items = [flexible, doneButton]
        $0.sizeToFit()
    }
    
    // MARK: - Object Lifecycle
    
    init(inputType: InputType, placeholder: String? = nil) {
        self.type = inputType
        self._placeholder = placeholder
        super.init(frame: .zero)
        setup()
        setupViews()
        setupConstraints()
        setupPadding()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        type != .detailDate ? bezierPathBorder(color: color) : ()
    }
    
    // MARK: - Override methods
    
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
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return (type == .date || type == .sms || type == .detailDate)  ? .zero : super.caretRect(for: position)
    }
}

// MARK: - Setup Views

private extension InputTextField {
    func setupViews() {
        switch type {
        case .password:
            addSubview(containerView)
            containerView.addArrangedSubview(hidePasswordButton)
        case .phone:
            addSubview(menuContainer)
            menuContainer.addArrangedSubview(menuButton)
        case .date:
            addSubview(containerView)
            containerView.addArrangedSubview(iconImageView)
        case .gender,.city, .country:
            addSubviews(containerView, menuContainer)
            menuContainer.addArrangedSubview(menuButton)
            containerView.addArrangedSubview(iconImageView)
        default:
            break
        }
        
        if let clearButton = value(forKeyPath: "_clearButton") as? UIButton {
            clearButton.setImage(AppImage.Auth.clear.uiImage?.withTintColor(color), for: .normal)
        }
    }
    
    func setupConstraints() {
        switch type {
        case .password, .date:
            containerView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.trailing.equalToSuperview()
                make.width.equalTo(50)
            }
        case .gender, .city, .country:
            containerView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.trailing.equalToSuperview()
                make.width.equalTo(50)
            }
            
            menuContainer.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        case .phone:
            menuContainer.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.leading.equalToSuperview()
                make.width.equalTo(70)
            }
        default:
            break
        }
        
    }
    
    func setupPadding() {
        switch type {
        case .password, .date, .gender, .city, .country:
            padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 60)
            placeholderPadding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 60)
        case .phone:
            padding = UIEdgeInsets(top: 16, left: 70, bottom: 16, right: 16)
            placeholderPadding = UIEdgeInsets(top: 16, left: 70, bottom: 16, right: 16)
        case .regular:
            padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 50)
            placeholderPadding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 50)
        default:
            break
        }
    }
    
    func setupBindings() {
        menuButton.didSelect = { [weak self] title in
            guard let self = self else { return }
            self.text = title
        }
        
        menuButton.didCountrySelect = { [weak self] in
            guard let self = self else { return }
            self.didCountrySelect?()
        }
        
        menuButton.didPhoneCodeSelect = { [weak self] code in
            guard let self = self else { return }
            self.didPhoneCodeSelect?(code)
        }
    }
}

// MARK: - Private methods

private extension InputTextField {
    func setup() {
        switch type {
        case .password:
            setupTextField(placeholder: "Введите пароль",
                           isSecureTextEntry: true,
                           textContentType: .password)
        case .date:
            setupTextField(placeholder: "Дата рождения",
                           textContentType: .dateTime,
                           image: AppImage.Auth.calendar.uiImage)
        case .phone:
            setupTextField(placeholder: "Введите номер телефона",
                           keyboardType: .phonePad,
                           clearButtonMode: .whileEditing,
                           textContentType: .telephoneNumber)
        case .sms:
            setupTextField(keyboardType: .numberPad,
                           font: AppFont.bold.s24,
                           textAlignment: .center,
                           textContentType: .oneTimeCode)
        case .regular:
            setupTextField(placeholder: _placeholder,
                           clearButtonMode: .whileEditing,
                           textContentType: .name)
        case .gender:
            setupTextField(placeholder: "Пол",
                           textContentType: .name,
                           image: AppImage.Auth.expandDown.uiImage)
        case .city:
            setupTextField(placeholder: "Город",
                           textContentType: .addressCity,
                           image: AppImage.Auth.expandDown.uiImage)
        case .country:
            setupTextField(placeholder: "Страна",
                           textContentType: .countryName,
                           image: AppImage.Auth.expandDown.uiImage)
        case .detailDate:
            setupTextField(backgroundColor: .clear, textContentType: .dateTime)
        }
    }
    
    func setupTextField(placeholder: String? = nil,
                        keyboardType: UIKeyboardType = .default,
                        font: UIFont = AppFont.medium.s16,
                        isSecureTextEntry: Bool = false,
                        clearButtonMode: UITextField.ViewMode = .never,
                        textColor: UIColor = AppColor.Static.darkGray.uiColor,
                        backgroundColor: UIColor = AppColor.Theme.mainBackground.uiColor,
                        textAlignment: NSTextAlignment = .natural,
                        isEnabled: Bool = true,
                        textContentType: UITextContentType,
                        image: UIImage? = nil) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.font = font
        self.isSecureTextEntry = isSecureTextEntry
        self.clearButtonMode = clearButtonMode
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.textAlignment = textAlignment
        self.isEnabled = isEnabled
        self.textContentType = textContentType
        iconImageView.image = image?.withTintColor(color)
        inputAccessoryView = toolbar
        delegate = self
    }
    
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

// MARK: - UITextFieldDelegate

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
        default:
            return false
        }
    }
}

// MARK: - Actions

private extension InputTextField {
    @objc func hidePasswordButtonTapped() {
        isSecureTextEntry.toggle()
        hidePasswordButton.isSelected.toggle()
    }
    
    @objc func doneButtonTapped() {
        endEditing(true)
    }
}
