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
    
    var textFieldDidTap: Callback<InputType>?
    var imageDidTap: VoidCallback?
    var didTap: VoidCallback?
    
    // MARK: - UI
    
    private lazy var profileImageView = UIImageView(image: AppImage.Personal.plus.uiImage).apply {
        $0.contentMode = .center
        $0.layer.borderColor = AppColor.Static.lightGray.cgColor
        $0.isUserInteractionEnabled = true
        $0.clipsToBounds = true
    }
    
    private lazy var firstNameTextField = InputTextField(inputType: .regular, placeHolder: "Имя")
    private lazy var secondNameTextField = InputTextField(inputType: .regular, placeHolder: "Фамилия")
    private lazy var birthdayTextField = InputTextField(inputType: .date).apply { $0.inputView = datePicker }
    private lazy var genderTextField = InputTextField(inputType: .gender)
    private lazy var countryTextField = InputTextField(inputType: .country)
    private lazy var cityTextField = InputTextField(inputType: .city)
    private lazy var continueButton = ProceedButton(type: .system).apply { 
        $0.type = .continue
        $0.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    private lazy var datePicker = UIDatePicker().apply {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        $0.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        $0.backgroundColor = AppColor.Theme.mainBackground.uiColor
    }
    
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
        countryTextField.layer.cornerRadius = 8
        cityTextField.layer.cornerRadius = 8
        continueButton.layer.cornerRadius = continueButton.frame.height / 2
    }
    
    // MARK: - Public methods
    
    func setProfileImage(image: UIImage) {
        profileImageView.image = image
        profileImageView.contentMode = .scaleAspectFit
    }
}

// MARK: - Setup Views

private extension PersonInformationView {
    func setupViews() {
        addSubviews(profileImageView, firstNameTextField, secondNameTextField, birthdayTextField,
                    genderTextField, countryTextField, cityTextField, continueButton)
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
        
        countryTextField.snp.makeConstraints { make in
            make.top.equalTo(genderTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        cityTextField.snp.makeConstraints { make in
            make.top.equalTo(countryTextField.snp.bottom).offset(16)
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
        genderTextField.didTap = { [weak self] type in
            guard let self = self else { return }
            self.endEditing(true)
            self.textFieldDidTap?(type)
        }
        countryTextField.didTap = { [weak self] type in
            guard let self = self else { return }
            self.endEditing(true)
            self.textFieldDidTap?(type)
        }
        cityTextField.didTap = { [weak self] type in
            guard let self = self else { return }
            self.endEditing(true)
            self.textFieldDidTap?(type)
        }
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                     action: #selector(profileImageViewTapped)))
    }
}

// MARK: - Private methods
// TODO: viewModel

private extension PersonInformationView {
    func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }
}

// MARK: - Actions

private extension PersonInformationView {
    @objc func continueButtonTapped() {
        didTap?()
    }
    
    @objc func profileImageViewTapped() {
        imageDidTap?()
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
