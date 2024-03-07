//
//  MainNavigationCell.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 04.03.2024.
//

import UIKit
import SnapKit

final class MainNavigationCell: UICollectionViewCell {

    // MARK: - Properties
    
    // TODO: - VM
    
    // MARK: - UI
    
    private lazy var iconImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFit
    }
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        contentView.addSubviews(iconImageView, containerView)
        containerView.addSubviews(titleLabel, separatorView, expandRightIconImageView)
    }
    
    func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(7)
            make.trailing.height.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.bottom.width.equalToSuperview()
        }
        
        expandRightIconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
}

// MARK: - Public methods

extension MainNavigationCell {
    func configure(iconImage: UIImage, title: String) {
        iconImageView.image = iconImage
        titleLabel.text = title
    }
}
