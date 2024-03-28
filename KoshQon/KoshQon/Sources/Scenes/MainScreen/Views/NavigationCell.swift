//
//  NavigationCell.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 04.03.2024.
//

import UIKit
import SnapKit

final class NavigationCell: BaseCell {

    // MARK: - Properties
    
    private var viewModel: NavigationCellViewModel? {
        didSet {
            if let vm = viewModel {
                setup(vm)
            }
        }
    }
    
    private let isLast: Bool
        
    // MARK: - UI
    
    private lazy var iconImageView = UIImageView()
    private lazy var containerView = UIView()
    
    private lazy var titleLabel = UILabel().apply {
        $0.set(font: AppFont.regular.s16, textColor: AppColor.Theme.mainTitle.uiColor)
    }
    
    private lazy var separatorView = SeparatorView()
    
    private lazy var expandRightIconImageView = UIImageView(image: AppImage.Common.expandRight.uiImage).apply {
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: - Object Lifecycle

    init(viewModel: NavigationCellViewModel) {
        self.isLast = viewModel.isLast
        defer {
            self.viewModel = viewModel
        }
        super.init()
        setupViews()
        setupConstraints()
    }

    // MARK: - Override methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        titleLabel.text = nil
    }
}

// MARK: - Setup Views

private extension NavigationCell {
    func setupViews() {
        backgroundColor = AppColor.Theme.mainBackground.uiColor
        contentView.addSubviews(iconImageView, containerView)
        containerView.addSubviews(titleLabel, expandRightIconImageView)
        if !isLast {
            containerView.addSubview(separatorView)
        }
    }
    
    func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
            make.top.bottom.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        if !isLast {
            separatorView.snp.makeConstraints { make in
                make.leading.trailing.bottom.equalToSuperview()
            }
        }
        
        expandRightIconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
}

// MARK: - Private methods

private extension NavigationCell {
    func setup(_ vm: NavigationCellViewModel) {
        titleLabel.text = vm.title
        iconImageView.image = vm.image
    }
}
