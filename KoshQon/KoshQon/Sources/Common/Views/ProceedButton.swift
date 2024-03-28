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
            configure()
        }
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        let orange = AppColor.Static.orange.uiColor
        let darkBlue = AppColor.Static.darkBlue.uiColor
        let green = AppColor.Static.green.uiColor
        
        let font16 = AppFont.medium.s16
        let font14 = AppFont.medium.s14
        
        switch type {
        case .signIn:
            setup(backgroundColor: orange, title: "Войти", font: font16)
        case .call:
            setup(backgroundColor: green, title: "Позвонить", font: font14)
        case .write:
            setup(backgroundColor: darkBlue, title: "Написать", font: font14)
        case .signUp:
            setup(backgroundColor: orange, title: "Создать аккаунт", font: font16)
        case .continue:
            setup(backgroundColor: orange, title: "Продолжить", font: font16)
        case .changePassword:
            setup(backgroundColor: orange, title: "Изменить пароль", font: font16)
        case .edit:
            setup(backgroundColor: orange, title: "Редактировать", font: font16)
        case .find:
            setup(backgroundColor: orange, title: "Искать объявления", font: font16)
        case .account:
            setup(backgroundColor: orange, title: "Перейти на страницу", font: font14)
        case .add:
            setup(backgroundColor: orange, font: font14, image: nil)
        case .save:
            setup(backgroundColor: orange, title: "Сохранить", font: font14)
        case .none:
            break
        }
    }
    
    private func setup(backgroundColor: UIColor, title: String? = nil, font: UIFont, image: UIImage? = nil) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        set(font: font, titleColor: AppColor.Static.white.uiColor)
        setImage(image, for: .normal)
    }
}
