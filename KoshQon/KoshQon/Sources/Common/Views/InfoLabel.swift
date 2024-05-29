//
//  InfoLabel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.02.2024.
//

import UIKit

enum InfoLabelType: String {
    case phone
    case password
    case noAccount
    case createPassword
    case repeatPassword
    case sms
    case resend
    case passwordContain
    case passwordRequirements
    case registration
    case forgotPassword
    case changePhone
    case favorites
    case empty
}

final class InfoLabel: UILabel {
    
    // MARK: - Properties
    
    private let type: InfoLabelType
    
    // MARK: - Object Lifecycle

    init(type: InfoLabelType) {
        self.type = type
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        switch type {
        case .phone:
            setup(text: LocalizableKeys.InfoLabel.phoneNumber.localized())
        case .password:
            setup(text: LocalizableKeys.InfoLabel.password.localized())
        case .noAccount:
            setup(text: LocalizableKeys.InfoLabel.noAccount.localized(),
                  textColor: AppColor.Theme.mainTitle.uiColor, textAlignment: .center)
        case .createPassword:
            setup(text: LocalizableKeys.InfoLabel.createPassword.localized())
        case .repeatPassword:
            setup(text: LocalizableKeys.InfoLabel.repeatPassword.localized())
        case .sms:
            setup(text: LocalizableKeys.InfoLabel.verificationCodeSent.localized())
        case .resend:
            setup(text: LocalizableKeys.InfoLabel.resendAfter.localized())
        case .passwordContain:
            setup(text: LocalizableKeys.InfoLabel.passwordMustContain.localized())
        case .passwordRequirements:
            let options = [
                LocalizableKeys.InfoLabel.atLeastEightDigits.localized(),
                LocalizableKeys.InfoLabel.digits.localized(),
                LocalizableKeys.InfoLabel.capitalAndLowercaseLetter.localized()
            ]
            setup(text: options.map { "· " + $0 }.joined(separator: "\n"),
                  textColor: AppColor.Theme.mainTitle.uiColor)
        case .registration:
            setup(text: LocalizableKeys.InfoLabel.phoneNumberLogin.localized(),
                  textAlignment: .center)
        case .forgotPassword:
            setup(text: LocalizableKeys.InfoLabel.phoneNumberRecover.localized(),
                  textAlignment: .center)
        case .changePhone:
            setup(text: LocalizableKeys.InfoLabel.phoneNumberAccount.localized(),
                  textAlignment: .center)
        case .favorites:
            setup(text: LocalizableKeys.InfoLabel.clickHeart.localized(),
                  textColor: AppColor.Theme.mainTitle.uiColor,
                  textAlignment: .center)
        case .empty:
            setup(text: LocalizableKeys.InfoLabel.empty.localized(), font: AppFont.medium.s16)
        }
    }
    
    private func setup(text: String,
                       textColor: UIColor = AppColor.Static.darkGray.uiColor,
                       font: UIFont = AppFont.regular.s16,
                       textAlignment: NSTextAlignment = .natural) {
        self.text = text
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        numberOfLines = 0
    }
}
