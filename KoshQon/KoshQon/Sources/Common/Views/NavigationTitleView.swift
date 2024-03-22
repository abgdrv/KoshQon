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
    case main
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
    private var isIcon: Bool
    
    override var intrinsicContentSize: CGSize {
        UIView.layoutFittingExpandedSize
    }
    
    // MARK: - UI
    
    private lazy var titleLabel = UILabel()
    
    private lazy var appIconImageView = UIImageView(image: AppImage.Common.AppIcon.uiImage).apply {
        $0.clipsToBounds = true
    }
    
    private lazy var containerView = UIStackView().apply {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.alignment = .center
    }
        
    // MARK: - Object Lifecycle
    
    init(type: NavigationTitleType, isIcon: Bool = false, title: String? = nil) {
        self.type = type
        self.title = title
        self.isIcon = isIcon
        super.init(frame: .zero)
        configure()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        appIconImageView.layer.cornerRadius = 5
    }
}

// MARK: - Setup Views

private extension NavigationTitleView {
    func setupViews() {
        addSubview(containerView)
        if isIcon {
            containerView.addArrangedSubview(appIconImageView)
            containerView.addArrangedSubview(titleLabel)
        } else {
            containerView.addArrangedSubview(titleLabel)
        }
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        if isIcon {
            appIconImageView.snp.makeConstraints { make in
                make.size.equalTo(30)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.width.equalTo(titleLabel.intrinsicContentSize)
            }
        }
    }
}

// MARK: - Private methods

private extension NavigationTitleView {
    func configure() {
        switch type {
        case .forgotPassword:
            setupLabel(text: "Забыл пароль")
        case .sms:
            setupLabel(text: "Код подтверждения")
        case .createPassword:
            setupLabel(text: "Создание пароля")
        case .personalInfo:
            setupLabel(text: "Личная информация")
        case .main:
            setupLabel(text: "KoshQon", font: AppFont.anta.s28)
        case .favorites:
            setupLabel(text: "Избранное")
        case .messages:
            setupLabel(text: "Сообщения")
        case .directMessages:
            setupLabel(text: title)
        case .profile:
            setupLabel(text: "Профиль")
        case .friends:
            setupLabel(text: "Друзья")
        case .settings:
            setupLabel(text: "Настройки")
        case .registration:
            setupLabel(text: "ID")
        }
    }
    
    func setupLabel(text: String?, font: UIFont = AppFont.medium.s20) {
        titleLabel.set(font: font, textColor: AppColor.Theme.mainTitle.uiColor)
        titleLabel.text = text
    }
}
