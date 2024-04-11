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
            setup(title: "Войти")
        case .signUp:
            setup(title: "Создать аккаунт")
        case .continue:
            setup(title: "Продолжить")
        case .changePassword:
            setup(title: "Изменить пароль")
        case .edit:
            setup(title: "Редактировать")
        case .find:
            setup(title: "Искать объявления")
        case .account:
            setup(title: "Перейти на страницу", font: AppFont.medium.s14)
        case .save:
            setup(title: "Сохранить")
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
