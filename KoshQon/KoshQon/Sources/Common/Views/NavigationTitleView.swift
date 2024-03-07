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
    case registration
}

final class NavigationTitleView: UIView {
    
    // MARK: - Properties
    
    private let type: NavigationTitleType
    private let title: String?
    private var isIcon = false
    private var isFirst = false
    
    // MARK: - UI
    
    private lazy var titleLabel = UILabel().apply { $0.textColor = AppColor.Theme.mainTitle.uiColor }
    
    private lazy var appIconImageView = UIImageView(image: AppImage.Common.AppIcon.uiImage).apply {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var containerView = UIStackView(arrangedSubviews: [appIconImageView, titleLabel]).apply {
        $0.axis = .horizontal
        $0.spacing = 5
    }

    // MARK: - Object Lifecycle
    
    init(type: NavigationTitleType, title: String? = nil) {
        self.type = type
        self.title = title
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        appIconImageView.layer.cornerRadius = 5
    }
    
    // MARK: - Private methods
    
    private func configure() {
        switch type {
        case .forgotPassword:
            setup(text: "Забыл пароль")
        case .sms:
            setup(text: "Код подтверждения")
        case .createPassword:
            setup(text: "Создание пароля")
        case .personalInfo:
            setup(text: "Личная информация")
        case .koshqon:
            setup(text: "KoshQon", font: AppFont.anta.s24)
            isFirst = true
        case .favorites:
            setup(text: "Избранное")
            isFirst = true
        case .messages:
            setup(text: "Сообщения")
            isFirst = true
        case .directMessages:
            setup(text: title)
        case .profile:
            setup(text: "Профиль")
        case .friends:
            setup(text: "Друзья")
        case .settings:
            setup(text: "Настройки")
        case .registration:
            setup(text: "ID")
            isIcon = true
        }
        
        setupViews()
        setupConstraints()
    }
    
    private func setup(text: String?, font: UIFont = AppFont.medium.s20) {
        titleLabel.text = text
        titleLabel.font = font
    }
}

// MARK: - Setup

private extension NavigationTitleView {
    func setupViews() {
        isIcon ? addSubviews(containerView) : addSubviews(titleLabel)
    }
    
    func setupConstraints() {
        if isIcon {
            containerView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            
            appIconImageView.snp.makeConstraints { make in
                make.size.equalTo(30)
            }
            return
        }
        
        titleLabel.snp.makeConstraints { make in
            if isFirst {
                make.trailing.equalToSuperview()
            } else {
                make.trailing.equalToSuperview().offset(20)
            }
            make.centerY.equalToSuperview()
        }
    }
}
