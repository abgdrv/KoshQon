//
//  InputLabel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.02.2024.
//

import UIKit

enum InputLabelType {
    case phone
    case password
    case createPassword
    case repeatPassword
    case sms
    case resend
}

final class InputLabel: UILabel {
    
    private let type: InputLabelType
    
    // MARK: - Object Lifecycle

    init(type: InputLabelType) {
        self.type = type
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        font = AppFont.regular.s16
        textColor = AppColor.Static.darkGray.uiColor
        textAlignment = .natural
        
        switch type {
        case .phone:
            setup(text: "Номер телефона")
        case .password:
            setup(text: "Пароль")
        case .createPassword:
            setup(text: "Придумайте пароль")
        case .repeatPassword:
            setup(text: "Повторите пароль")
        case .sms:
            setup(text: "Код подтверждения отправлен на")
        case .resend:
            setup(text: "Переотправить через")
        }
    }
    
    private func setup(text: String) {
        self.text = text
    }
}
