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
    case call
    case write
    case add
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
        case .call:
            setup(backgroundColor: AppColor.Static.green.uiColor, title: "Позвонить", font: AppFont.medium.s14)
        case .write:
            setup(backgroundColor: AppColor.Static.darkBlue.uiColor, title: "Написать", font: AppFont.medium.s14)
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
        case .add:
            setup(font: AppFont.medium.s14, image: nil)
        case .save:
            setup(title: "Сохранить")
        case .none:
            break
        }
    }
    
    private func setup(backgroundColor: UIColor = AppColor.Static.orange.uiColor,
                       title: String? = nil,
                       font: UIFont = AppFont.medium.s16,
                       image: UIImage? = nil) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        set(font: font, titleColor: AppColor.Static.white.uiColor)
        setImage(image, for: .normal)
    }
}
