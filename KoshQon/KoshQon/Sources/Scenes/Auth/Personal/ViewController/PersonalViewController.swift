//
//  PersonalViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 29.02.2024.
//

import UIKit
import SnapKit
import RSKImageCropper

final class PersonalViewController: BaseViewController, ImageSettable {
    
    // MARK: - Properties
    
    var didFinish: VoidCallback?
    var didImagePickerOptionsShow: PairCallback<UIImagePickerController, Bool>?
    var didCropCancel: VoidCallback?
    var didImageCrop: VoidCallback?
    var didCropImageShow: Callback<RSKImageCropViewController>?
    var didImageDelete: VoidCallback? {
        didSet {
            profileImageView.image = AppImage.Personal.defaultProfile.uiImage
        }
    }
    
    var image: UIImage? {
        return profileImageView.image
    }
    
    private let viewModel: PersonalViewModel
    
    private var isImageSelected: Bool {
        return profileImageView.image != AppImage.Personal.defaultProfile.uiImage
    }
    
    override var navigationTitleType: NavigationTitleType? {
        return .personalInfo
    }
    
    // MARK: - UI
        
    private lazy var profileImageView = ProfileImageView(isEditable: true)
    private lazy var firstNameTextField = InputTextField(inputType: .regular, placeholder: LocalizableKeys.Auth.fname.localized())
    private lazy var lastNameTextField = InputTextField(inputType: .regular, placeholder: LocalizableKeys.Auth.lname.localized())
    private lazy var birthdayTextField = InputTextField(inputType: .date).apply { $0.inputView = datePicker }
    private lazy var genderTextField = InputTextField(inputType: .gender)
    private lazy var countryTextField = InputTextField(inputType: .country)
    private lazy var cityTextField = InputTextField(inputType: .city).apply { $0.alpha = 0 }
    
    private lazy var continueButton = ProceedButton(type: .system).apply {
        $0.type = .continue
        $0.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    private lazy var datePicker = DatePicker(format: "dd.MM.yyyy")
    private lazy var imagePicker = UIImagePickerController().apply { $0.delegate = self }
    
    // MARK: - Object Lifecycle
    
    init(viewModel: PersonalViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupBindings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        firstNameTextField.layer.cornerRadius = 8
        lastNameTextField.layer.cornerRadius = 8
        birthdayTextField.layer.cornerRadius = 8
        genderTextField.layer.cornerRadius = 8
        countryTextField.layer.cornerRadius = 8
        cityTextField.layer.cornerRadius = 8
        continueButton.layer.cornerRadius = continueButton.frame.height / 2
    }
}

// MARK: - Setup Views

private extension PersonalViewController {
    func setupViews() {
        view.addSubviews(profileImageView, firstNameTextField, lastNameTextField,
                         birthdayTextField, genderTextField, countryTextField, continueButton)
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(116)
        }
        
        firstNameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        lastNameTextField.snp.makeConstraints { make in
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
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    func setupCityTextField() {
        if view.subviews.contains(cityTextField) {
            cityTextField.removeFromSuperview()
        }
        cityTextField = InputTextField(inputType: .city).apply {
            $0.alpha = 0
            $0.layer.cornerRadius = 8
        }
        view.addSubview(cityTextField)
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
            self.didImagePickerOptionsShow?(self.imagePicker ,self.isImageSelected)
        }
                
        datePicker.didDateChange = { [weak self] selectedDate in
            guard let self = self else { return }
            birthdayTextField.text = selectedDate
        }
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate, RSKImageCropViewControllerDelegate

extension PersonalViewController: UIImagePickerControllerDelegate,
                                  RSKImageCropViewControllerDelegate,
                                  UINavigationControllerDelegate {
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        didCropCancel?()
    }
    
    func imageCropViewController(_ controller: RSKImageCropViewController,
                                 didCropImage croppedImage: UIImage,
                                 usingCropRect cropRect: CGRect,
                                 rotationAngle: CGFloat) {
        profileImageView.image = croppedImage
        didImageCrop?()
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage ?? UIImage()
        picker.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            let imageCropVC = RSKImageCropViewController(image: image, cropMode: .circle)
            imageCropVC.delegate = self
            self.didCropImageShow?(imageCropVC)
        }
    }
}

// MARK: - Actions

private extension PersonalViewController {
    @objc func continueButtonTapped() {
        AppData.shared.user.image = image
        AppData.shared.user.fname = firstNameTextField.text ?? ""
        AppData.shared.user.lname = lastNameTextField.text ?? ""
        AppData.shared.user.birthday = datePicker.date
        AppData.shared.user.gender = .male
        AppData.shared.user.country = .kz
        AppData.shared.user.city = .almaty
        
        didFinish?()
    }
}
