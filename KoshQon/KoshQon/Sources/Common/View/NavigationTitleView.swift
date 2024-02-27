//
//  NavigationTitleView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 27.02.2024.
//

import UIKit
import SnapKit

enum NavigationTitleType {
    case forgotPassword
    case sms
    case createPassword
    case personalInfo
    case koshqon
    case favorites
    case messages
    case directMessages
    case profile
    case friends
    case settings
}

final class NavigationTitleView: UIView {
    
    // MARK: - Properties
    
    private let type: NavigationTitleType
    private let title: String?
    
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.Theme.mainTitle.uiColor
        label.font = AppFont.medium.s20
        return label
    }()

    // MARK: - Object Lifecycle
    
    init(type: NavigationTitleType, title: String? = nil) {
        self.type = type
        self.title = title
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func configure() {
        switch type {
        case .forgotPassword:
            titleLabel.text = "Забыл пароль"
        case .sms:
            titleLabel.text = "Код подтверждения"
        case .createPassword:
            titleLabel.text = "Создание пароля"
        case .personalInfo:
            titleLabel.text = "Личная информация"
        case .koshqon:
            titleLabel.text = "KoshQon"
            titleLabel.font = AppFont.anta.s24
        case .favorites:
            titleLabel.text = "Избранное"
        case .messages:
            titleLabel.text = "Сообщения"
        case .directMessages:
            titleLabel.text = title
        case .profile:
            titleLabel.text = "Профиль"
        case .friends:
            titleLabel.text = "Друзья"
        case .settings:
            titleLabel.text = "Настройки"
        }
    }
}

// MARK: - Setup Views, Constraints

private extension NavigationTitleView {
    func setupViews() {
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.trailing.centerY.equalToSuperview()
        }
    }
}
