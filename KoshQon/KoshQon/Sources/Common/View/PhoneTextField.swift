//
//  PhoneTextField.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 20.02.2024.
//

import UIKit
import PhoneNumberKit

final class PhoneTextField: PhoneNumberTextField {
    
    // MARK: - Properties
    
    private let padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    private let placeholderPadding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    private let maxPhoneNumberDigits = 10
    
    // MARK: - Object Lifecycle
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        textColor = AppColor.darkGray.uiColor
        backgroundColor = AppColor.mainBackground.uiColor
        layer.borderColor = AppColor.lightGray.cgColor
        layer.borderWidth = 1
        clipsToBounds = true
        autocapitalizationType = .none
        autocorrectionType = .no
        spellCheckingType = .no
        clearsOnBeginEditing = false
        withPrefix = true
        withExamplePlaceholder = true
        withDefaultPickerUI = true
        maxDigits = maxPhoneNumberDigits
        addTarget(self, action: #selector(formatPhoneNumber), for: .editingChanged)
        clearButtonMode = .whileEditing
    }
    
    @objc private func formatPhoneNumber() {
        guard let text = text else { return }
        do {
            let phoneNumber = try phoneNumberKit.parse(text, withRegion: "KZ")
            let formattedNumber = phoneNumberKit.format(phoneNumber, toType: .international)
            self.text = formattedNumber
        } catch {
            print("Invalid phone number")
        }
    }
    
}
