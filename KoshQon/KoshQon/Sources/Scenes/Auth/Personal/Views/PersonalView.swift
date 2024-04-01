//
//  PersonalView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 29.02.2024.
//

import UIKit
import SnapKit


final class PersonalView: BaseView {
    
    // MARK: - Properties
    
    var didFinish: VoidCallback?
    var didImageTap: VoidCallback?
    
    // MARK: - UI
    
    private lazy var profileImageView = ProfileImageView(isEditable: true)
    private lazy var firstNameTextField = InputTextField(inputType: .regular, placeholder: "Имя")
    private lazy var secondNameTextField = InputTextField(inputType: .regular, placeholder: "Фамилия")
    private lazy var birthdayTextField = InputTextField(inputType: .date).apply { $0.inputView = datePicker }
    private lazy var genderTextField = InputTextField(inputType: .gender)
    private lazy var countryTextField = InputTextField(inputType: .country)
    private lazy var cityTextField = InputTextField(inputType: .city).apply { $0.alpha = 0 }
    
    private lazy var continueButton = ProceedButton(type: .system).apply {
        $0.type = .continue
        $0.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    private lazy var datePicker = DatePicker(format: "dd.MM.yyyy")
    
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
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        firstNameTextField.layer.cornerRadius = 8
        secondNameTextField.layer.cornerRadius = 8
        birthdayTextField.layer.cornerRadius = 8
        genderTextField.layer.cornerRadius = 8
        countryTextField.layer.cornerRadius = 8
        cityTextField.layer.cornerRadius = 8
        continueButton.layer.cornerRadius = continueButton.frame.height / 2
    }
    
    // MARK: - Public methods
    
    func setProfileImage(image: UIImage?) {
        profileImageView.image = image
    }
}

// MARK: - Setup Views

private extension PersonalView {
    func setupViews() {
        addSubviews(profileImageView, firstNameTextField, secondNameTextField,
                    birthdayTextField, genderTextField, countryTextField, continueButton)
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalToSuperview().offset(16)
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
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    func setupCityTextField() {
        if subviews.contains(cityTextField) {
            cityTextField.removeFromSuperview()
        }
        cityTextField = InputTextField(inputType: .city).apply {
            $0.alpha = 0
            $0.layer.cornerRadius = 8
        }
        addSubview(cityTextField)
        cityTextField.snp.makeConstraints { make in
            make.top.equalTo(countryTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        UIView.animate(withDuration: 0.3) {
            self.cityTextField.alpha = 1
        }
    }
    
    func setupBindings() {
        countryTextField.didCountrySelect = { [weak self] in
            guard let self = self else { return }
            self.setupCityTextField()
        }
        
        profileImageView.didImageTap = { [weak self] in
            guard let self = self else { return }
            self.didImageTap?()
        }
        
        datePicker.didDateChange = { [weak self] selectedDate in
            guard let self = self else { return }
            birthdayTextField.text = selectedDate
        }
    }
}

// MARK: - Actions

private extension PersonalView {
    @objc func continueButtonTapped() {
        didFinish?()
    }
}
