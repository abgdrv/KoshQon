//
//  InfoLabel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.02.2024.
//

import UIKit

enum InfoLabelType {
    case phone
    case password
    case noAccount
    case createPassword
    case repeatPassword
    case sms
    case resend
    case passwordContain
    case passwordRequirements
    case registerPhone
    case forgotPassword
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
            setup(text: "Номер телефона")
        case .password:
            setup(text: "Пароль")
        case .noAccount:
            setup(text: "У вас нет аккаунта?",
                  textColor: AppColor.Theme.mainTitle.uiColor,
                  textAlignment: .right)
        case .createPassword:
            setup(text: "Придумайте пароль")
        case .repeatPassword:
            setup(text: "Повторите пароль")
        case .sms:
            setup(text: "Код подтверждения отправлен на")
        case .resend:
            setup(text: "Переотправить через")
        case .passwordContain:
            setup(text: "Пароль должен содержать:")
        case .passwordRequirements:
            let options = ["Не менее 8 символов", "Цифры","Заглавные и строчные буквы"]
            setup(text: options.map { "· " + $0 }.joined(separator: "\n"),
                  textColor: AppColor.Theme.mainTitle.uiColor)
        case .registerPhone:
            setup(text: "Ваш номер телефона будет использоваться для входа в вашу учетную запись",
                  textAlignment: .center)
        case .forgotPassword:
            setup(text: "Для восстановления вашего пароля требуется ваш номер телефона, связанный с учетной записью",
                  textAlignment: .center)
        case .favorites:
            setup(text: "Нажимайте на сердечко возле объявлений, чтобы не потерять их",
                  textColor: AppColor.Theme.mainTitle.uiColor,
                  textAlignment: .center)
        case .empty:
            setup(text: "Пусто", font: AppFont.medium.s16)
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
