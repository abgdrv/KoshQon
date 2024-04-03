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
    
    var didSave: VoidCallback?
    
    private var existingText: String?
    
    @Published private var counterString: String = "150"
    
    private var cancellables = Set<AnyCancellable>()
    
    override var keyboardHandlingButton: ProceedButton? {
        return saveButton
    }
    
    // MARK: - UI
    
    private lazy var aboutMeContainer = UIView()
    
    private lazy var aboutMeTextView = UITextView().apply {
        $0.delegate = self
        $0.textColor = UIColor.lightGray
        $0.text = existingText
        $0.isEditable = true
        $0.font = AppFont.regular.s18
        $0.backgroundColor = .clear
        $0.selectedTextRange = $0.textRange(from: $0.beginningOfDocument, to: $0.beginningOfDocument)
        $0.becomeFirstResponder()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 5
        let attributedString = NSAttributedString(
            string: $0.text,
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle,
                         NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                         NSAttributedString.Key.font: AppFont.regular.s18]
        )
        $0.attributedText = attributedString
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
    
    init(existingText: String?) {
        self.existingText = existingText ?? "Я люблю заниматься спортом и читать книги..."
        super.init()
        setupViews()
        setupConstraints()
        bind()
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
        let currentText: String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        if updatedText.count > 150 {
            return false
        }
        if updatedText.isEmpty {
            textView.text = "Я люблю заниматься спортом и читать книги..."
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        } else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = AppColor.Static.darkGray.uiColor
            textView.text = text
        } else {
            return true
        }
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
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
        NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification,
                                             object: aboutMeTextView)
        .sink { [weak self] _ in
            guard let self = self else { return }
            let remainingCharacters = 150 - (self.aboutMeTextView.text.count)
            self.counterLabel.text = "\(remainingCharacters)"
        }
        .store(in: &cancellables)
    }
}

// MARK: - Actions

private extension ProfileAboutMeView {
    @objc func saveButtonTapped() {
        didSave?()
    }
}
