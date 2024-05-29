//
//  NavigationTitleView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 27.02.2024.
//

import UIKit
import SnapKit

enum NavigationTitleType: String {
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
    case myAnnouncements
    case changePhone
    case aboutMe
    case privacy
    case theme
    case characteristics
    case language
}

final class NavigationTitleView: UIView {
    
    // MARK: - Properties
    
    var title: String?
    
    private let type: NavigationTitleType?
    private var isIcon = false
    
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
    
    init(type: NavigationTitleType?, title: String? = nil) {
        self.type = type
        self.title = title
        super.init(frame: .zero)
        setup()
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
    func setup() {
        switch type {
        case .forgotPassword:
            setupLabel(text: LocalizableKeys.NavigationBar.forgotPassword.localized())
        case .sms:
            setupLabel(text: LocalizableKeys.NavigationBar.confirmationCode.localized())
        case .createPassword:
            setupLabel(text: LocalizableKeys.NavigationBar.passwordCreation.localized())
        case .personalInfo:
            setupLabel(text: LocalizableKeys.NavigationBar.personalInfo.localized())
        case .main:
            setupLabel(text: Constants.App.name, font: AppFont.anta.s28)
        case .favorites:
            setupLabel(text: LocalizableKeys.NavigationBar.favorites.localized())
        case .messages:
            setupLabel(text: LocalizableKeys.NavigationBar.messages.localized())
        case .directMessages:
            setupLabel(text: title)
        case .profile:
            setupLabel(text: LocalizableKeys.NavigationBar.profile.localized())
        case .friends:
            setupLabel(text: LocalizableKeys.NavigationBar.friends.localized())
        case .settings:
            setupLabel(text: LocalizableKeys.NavigationBar.settings.localized())
        case .registration:
            setupLabel(text: "ID")
            isIcon = true
        case .myAnnouncements:
            setupLabel(text: LocalizableKeys.NavigationBar.myAnnouncements.localized())
        case .changePhone:
            setupLabel(text: LocalizableKeys.NavigationBar.changePhoneNumber.localized())
        case .aboutMe:
            setupLabel(text: LocalizableKeys.NavigationBar.aboutMe.localized())
        case .privacy:
            setupLabel(text: LocalizableKeys.NavigationBar.confidentiality.localized())
        case .theme:
            setupLabel(text: LocalizableKeys.NavigationBar.appTheme.localized())
        case .characteristics:
            setupLabel(text: LocalizableKeys.NavigationBar.characteristics.localized())
        case .language:
            setupLabel(text: LocalizableKeys.NavigationBar.language.localized())
        case .none:
            break
        }
    }
    
    func setupLabel(text: String?, font: UIFont = AppFont.medium.s20) {
        titleLabel.set(font: font, textColor: AppColor.Theme.mainTitle.uiColor)
        titleLabel.text = text
        title = text
    }
}
