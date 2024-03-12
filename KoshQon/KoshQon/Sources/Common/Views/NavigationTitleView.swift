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
    
    // MARK: - UI
    
    private lazy var titleLabel = UILabel().apply { $0.textColor = AppColor.Theme.mainTitle.uiColor }
    
    private lazy var appIconImageView = UIImageView(image: AppImage.Common.AppIcon.uiImage).apply {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var containerView = UIStackView().apply {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.alignment = isIcon ? .center : .leading
    }
    
    private lazy var spacerView = UIView().apply {
        let constraint = $0.widthAnchor.constraint(greaterThanOrEqualToConstant: CGFloat.greatestFiniteMagnitude)
        constraint.isActive = true
        constraint.priority = .defaultLow
    }

    // MARK: - Object Lifecycle
    
    init(type: NavigationTitleType, isIcon: Bool = false, title: String? = nil) {
        self.type = type
        self.title = title
        self.isIcon = isIcon
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
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
            setup(text: "KoshQon", font: AppFont.anta.s28)
        case .favorites:
            setup(text: "Избранное")
        case .messages:
            setup(text: "Сообщения")
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
        addSubviews(containerView)
        if isIcon {
            containerView.addArrangedSubview(appIconImageView)
            containerView.addArrangedSubview(titleLabel)
        } else {
            containerView.addArrangedSubview(titleLabel)
            containerView.addArrangedSubview(spacerView)
        }
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
