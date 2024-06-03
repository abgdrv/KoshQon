//
//  ProfileAboutView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 15.03.2024.
//

import UIKit
import SnapKit

final class ProfileAboutView: HighlightView {

    // MARK: - Properties
    
    private var info: ProfileAboutInfo? {
        didSet {
            aboutTextLabel.text = info?.text
        }
    }
    
    let viewModel: ProfileViewModel
    
    // MARK: - UI
    
    private lazy var containerView = UIView().apply {
        $0.backgroundColor = AppColor.Theme.blockBackground.uiColor
    }
        
    private lazy var aboutTitleLabel = UILabel().apply {
        $0.set(font: AppFont.medium.s20, textColor: AppColor.Theme.mainTitle.uiColor)
        $0.text = LocalizableKeys.NavigationBar.aboutMe.localized()
    }
    
    lazy var aboutTextLabel = UILabel().apply {
        $0.font = AppFont.regular.s12
        $0.textColor = AppColor.Static.darkGray.uiColor
        $0.numberOfLines = 0
        $0.text = viewModel.profileType == .myProfile ? AppData.shared.user.about : viewModel.user.about
    }
    
    private lazy var contentView = UIStackView(arrangedSubviews: [aboutTitleLabel, aboutTextLabel]).apply {
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    // MARK: - Object Lifecycle
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 10
    }
}

// MARK: - Setup Views

private extension ProfileAboutView {
    func setupViews() {
        addSubview(containerView)
        containerView.addSubview(contentView)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
