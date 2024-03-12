//
//  MainNavigationCell.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 04.03.2024.
//

import UIKit
import SnapKit

final class MainNavigationCell: UITableViewCell {

    // MARK: - Properties
    
    // TODO: - VM
    
    // MARK: - UI
    
    private lazy var iconImageView = UIImageView().apply { $0.contentMode = .scaleAspectFit }
    private lazy var containerView = UIView()
    
    private lazy var titleLabel = UILabel().apply {
        $0.set(font: AppFont.regular.s16, textColor: AppColor.Theme.mainTitle.uiColor)
    }
    
    private lazy var separatorView = SeparatorView()
    
    private lazy var expandRightIconImageView = UIImageView().apply {
        $0.image = AppImage.Common.expandRight.uiImage
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: - Object Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views

private extension MainNavigationCell {
    func setupViews() {
        backgroundColor = AppColor.Theme.mainBackground.uiColor
        contentView.addSubviews(iconImageView, containerView)
        containerView.addSubviews(titleLabel, expandRightIconImageView, separatorView)
    }
    
    func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
            make.trailing.height.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        separatorView.snp.makeConstraints { make in
            make.bottom.width.equalToSuperview()
            make.height.equalTo(1)
        }
        
        expandRightIconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
}

// MARK: - Public methods

extension MainNavigationCell {
    func configure(iconImage: UIImage?, title: String) {
        iconImageView.image = iconImage
        titleLabel.text = title
    }
}
