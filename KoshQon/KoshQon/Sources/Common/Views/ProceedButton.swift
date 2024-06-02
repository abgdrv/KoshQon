//
//  ProceedButton.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.02.2024.
//

import UIKit

enum ProceedButtonType {
    case signIn
    case signUp
    case `continue`
    case changePassword
    case edit
    case find
    case account
    case save
    case create
}

final class ProceedButton: UIButton {
    
    // MARK: - Properties
    
    var type: ProceedButtonType? {
        didSet {
            setup()
        }
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        switch type {
        case .signIn:
            setup(title: LocalizableKeys.ProceedButton.signIn.localized())
        case .signUp:
            setup(title: LocalizableKeys.ProceedButton.createAccount.localized())
        case .continue:
            setup(title: LocalizableKeys.ProceedButton.continue.localized())
        case .changePassword:
            setup(title: LocalizableKeys.ProceedButton.changePassword.localized())
        case .edit:
            setup(title: LocalizableKeys.ProceedButton.edit.localized())
        case .find:
            setup(title: LocalizableKeys.ProceedButton.searchAnnouncements.localized())
        case .account:
            setup(title: LocalizableKeys.ProceedButton.goToPage.localized(), font: AppFont.medium.s14)
        case .save:
            setup(title: LocalizableKeys.ProceedButton.save.localized())
        case .create:
            setup(title: "Создать")
        case .none:
            break
        }
    }
    
    private func setup(
        backgroundColor: UIColor = AppColor.Static.orange.uiColor,
        title: String? = nil,
        font: UIFont = AppFont.medium.s16
    ) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        set(font: font, titleColor: AppColor.Static.white.uiColor)
    }
}
