//
//  ProfileAboutMeView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.04.2024.
//

import UIKit
import SnapKit

final class ProfileAboutMeView: BaseView {

    // MARK: - Properties
    
    var didSave: VoidCallback?
    
    private var existingText: String
    
    private var counterString: String {
        let text = aboutMeTextField.text ?? ""
        return "\(100 - text.count)"
    }
    
    override var keyboardHandlingButton: ProceedButton? {
        return saveButton
    }
    
    // MARK: - UI
    
    private lazy var aboutMeTextField = InputTextField(inputType: .aboutMe).apply {
        $0.text = existingText
    }
    
    private lazy var counterLabel = UILabel().apply {
        $0.set(font: AppFont.regular.s16, textColor: AppColor.Static.darkGray.uiColor)
        $0.text = counterString
    }
    
    private lazy var saveButton = ProceedButton(type: .system).apply {
        $0.type = .save
        $0.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    // MARK: - Object Lifecycle
    
    init(existingText: String) {
        self.existingText = existingText
        super.init()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        aboutMeTextField.layer.cornerRadius = 8
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
    }
}

// MARK: - Setup Views

private extension ProfileAboutMeView {
    func setupViews() {
        addSubviews(aboutMeTextField, counterLabel, saveButton)
    }
    
    func setupConstraints() {
        aboutMeTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(200)
        }
        
        counterLabel.snp.makeConstraints { make in
            make.top.equalTo(aboutMeTextField.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(16)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}

// MARK: - Actions

private extension ProfileAboutMeView {
    @objc func saveButtonTapped() {
        didSave?()
    }
}
