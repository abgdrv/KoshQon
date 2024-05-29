//
//  ProfileAboutMeView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.04.2024.
//

import UIKit
import SnapKit
import Combine

final class ProfileAboutMeView: BaseView {
    
    // MARK: - Properties
    
    var didSave: Callback<String>?
    
    private var existingText: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    override var keyboardHandlingButton: ProceedButton? {
        return saveButton
    }
    
    private let placeholder = LocalizableKeys.Profile.aboutPlaceholder.localized()
    
    // MARK: - UI
    
    private lazy var aboutMeContainer = UIView()
    
    private lazy var aboutMeTextView = UITextView().apply {
        $0.delegate = self
        $0.textColor = AppColor.Static.darkGray.uiColor
        $0.text = existingText ?? ""
        $0.isEditable = true
        $0.font = AppFont.regular.s18
        $0.backgroundColor = .clear
        if $0.text.isEmpty {
            $0.text = placeholder
            $0.textColor = .lightGray
            $0.selectedRange = NSRange(location: 0, length: 0)
        }
        $0.becomeFirstResponder()
    }
    
    private lazy var counterLabel = UILabel().apply {
        $0.set(font: AppFont.regular.s16, textColor: AppColor.Static.darkGray.uiColor)
        $0.text = "\(150 - (existingText?.count ?? 0))"
    }
    
    private lazy var saveButton = ProceedButton(type: .system).apply {
        $0.type = .save
        $0.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Object Lifecycle
    
    init(existingText: String?) {
        self.existingText = existingText
        super.init()
        setupViews()
        setupConstraints()
        setupBindings()
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        aboutMeContainer.layer.cornerRadius = 8
        aboutMeContainer.bezierPathBorder(color: AppColor.Theme.separation.uiColor)
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
    }
}

extension ProfileAboutMeView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let currentText = textView.text, let textRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: textRange, with: text)
        
        guard updatedText.count <= 150 else { return false }
        
        if textView.text == placeholder && !text.isEmpty {
            textView.text = text
            textView.textColor = AppColor.Static.darkGray.uiColor
            textView.selectedRange = NSRange(location: text.count, length: 0)
            return false
        }
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = .lightGray
            textView.selectedRange = NSRange(location: 0, length: 0)
        } else if textView.text == placeholder {
            textView.textColor = AppColor.Static.darkGray.uiColor
        }
    }
}

// MARK: - Setup Views

private extension ProfileAboutMeView {
    func setupViews() {
        addSubviews(aboutMeContainer, counterLabel, saveButton)
        aboutMeContainer.addSubview(aboutMeTextView)
    }
    
    func setupConstraints() {
        aboutMeContainer.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(150)
        }
        
        aboutMeTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        counterLabel.snp.makeConstraints { make in
            make.top.equalTo(aboutMeContainer.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(16)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    func setupBindings() {
        NotificationCenter.default.publisher(
            for: UITextView.textDidChangeNotification,
            object: aboutMeTextView
        )
        .sink { [weak self] _ in
            guard let self = self else { return }
            var remainingCharacters = 150 - (self.aboutMeTextView.text.count)
            if aboutMeTextView.text == placeholder {
                remainingCharacters = 150
            }
            self.counterLabel.text = "\(remainingCharacters)"
        }
        .store(in: &cancellables)
    }
}

// MARK: - Actions

private extension ProfileAboutMeView {
    @objc func saveButtonTapped() {
        didSave?(aboutMeTextView.text == placeholder ? "" : aboutMeTextView.text)
    }
}
