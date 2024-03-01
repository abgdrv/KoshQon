//
//  PersonInformationView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 29.02.2024.
//

import UIKit
import SnapKit


final class PersonInformationView: BaseView {

    // MARK: - Properties
    
    var onAction: Callback<InputType>?
    
    // MARK: - UI
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(image: AppImage.Personal.plus.uiImage)
        imageView.contentMode = .center
        imageView.layer.borderColor = AppColor.Static.lightGray.cgColor
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                              action: #selector(profileImageViewTapped)))
        return imageView
    }()
    
    private lazy var firstNameTextField = InputTextField(inputType: .regular, placeHolder: "Имя")
    private lazy var secondNameTextField = InputTextField(inputType: .regular, placeHolder: "Фамилия")
    private lazy var birthdayTextField: InputTextField = {
        let textField = InputTextField(inputType: .date)
        textField.inputView = datePicker
        return textField
    }()
    private lazy var genderTextField = InputTextField(inputType: .gender)
    private lazy var cityTextField = InputTextField(inputType: .city)
    
    private lazy var continueButton: ProceedButton = {
        let button = ProceedButton(type: .system)
        button.type = .continue
        return button
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        datePicker.backgroundColor = AppColor.Theme.mainBackground.uiColor
        return datePicker
    }()
    
    // MARK: - Object Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupObservers()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.borderWidth = 1
        firstNameTextField.layer.cornerRadius = 8
        secondNameTextField.layer.cornerRadius = 8
        birthdayTextField.layer.cornerRadius = 8
        genderTextField.layer.cornerRadius = 8
        cityTextField.layer.cornerRadius = 8
        continueButton.layer.cornerRadius = continueButton.frame.height / 2
    }
}

// MARK: - Setup Views

private extension PersonInformationView {
    func setupViews() {
        [profileImageView, firstNameTextField, secondNameTextField,
         birthdayTextField, genderTextField, cityTextField, continueButton].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(116)
        }
        
        firstNameTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        secondNameTextField.snp.makeConstraints { make in
            make.top.equalTo(firstNameTextField.snp.bottom).offset(16)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        birthdayTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        genderTextField.snp.makeConstraints { make in
            make.top.equalTo(birthdayTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        cityTextField.snp.makeConstraints { make in
            make.top.equalTo(genderTextField.snp.bottom).offset(16)
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
    
    func setupBindings() {
        birthdayTextField.onAction = { [weak self] type in
            guard let self = self else { return }
            self.onAction?(type)
        }
        
        genderTextField.onAction = { [weak self] type in
            guard let self = self else { return }
            self.onAction?(type)
        }
        
        cityTextField.onAction = { [weak self] type in
            guard let self = self else { return }
            self.onAction?(type)
        }
    }
}

// MARK: - Private methods

private extension PersonInformationView {
    func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }
}

// MARK: - Actions

private extension PersonInformationView {
    @objc func profileImageViewTapped() {
        
    }
    
    @objc func dateChanged() {
        birthdayTextField.text = formattedDate(date: datePicker.date)
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
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}
