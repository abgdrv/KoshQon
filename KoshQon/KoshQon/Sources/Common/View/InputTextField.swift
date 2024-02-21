//
//  InputTextField.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.02.2024.
//

import UIKit

final class InputTextField: UITextField {
    
    // MARK: - Properties

    private let padding: UIEdgeInsets
    private let placeholderPadding: UIEdgeInsets
    
    // MARK: - Object Lifecycle
    
    init(isButton: Bool) {
        padding = isButton
                  ? UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 60)
                  : UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        placeholderPadding = isButton
                             ? UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 60)
                             : UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
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
        clearButtonMode = .whileEditing
    }
}
