//
//  ProfileDetailCell.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import UIKit
import SnapKit

final class ProfileDetailCell: BaseCell {

    // MARK: - Properties
    
    var didProfileDetailCellTap: Callback<ProfileDetailType>?
    
    private var viewModel: ProfileDetailCellViewModel? {
        didSet {
            if let vm = viewModel {
                setup(vm)
            }
        }
    }
    
    private let isEditable: Bool
    private var isLast: Bool
    
    // MARK: - UI
    
    private lazy var titleLabel = UILabel().apply {
        $0.set(font: AppFont.medium.s16, textColor: AppColor.Theme.mainTitle.uiColor)
    }
    
    private lazy var valueLabel = UILabel().apply {
        $0.set(font: AppFont.regular.s16, textColor: AppColor.Static.darkGray.uiColor)
    }
    
    private lazy var expandRightIconImageView = UIImageView(image: AppImage.Common.expandRight.uiImage).apply {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var separatorView = SeparatorView()
    
    // MARK: - Object Lifecycle
    
    init(viewModel: ProfileDetailCellViewModel) {
        defer {
            self.viewModel = viewModel
        }
        self.isEditable = viewModel.isEditable
        self.isLast = viewModel.isLast
        super.init()
        setupViews()
        setupConstraints()
        setupBindings()
    }
}

// MARK: - Setup Views

private extension ProfileDetailCell {
    func setupViews() {
        backgroundColor = AppColor.Theme.blockBackground.uiColor
        contentView.addSubviews(titleLabel, valueLabel)
        if isEditable {
            contentView.addSubview(expandRightIconImageView)
        }
        if !isLast {
            contentView.addSubview(separatorView)
        }
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        if isEditable {
            expandRightIconImageView.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(5)
                make.centerY.equalToSuperview()
                make.size.equalTo(24)
            }
            
            valueLabel.snp.makeConstraints { make in
                make.leading.equalTo(titleLabel.snp.trailing).offset(10)
                make.trailing.equalTo(expandRightIconImageView.snp.leading).offset(-5)
                make.centerY.equalToSuperview()
            }
        } else {
            valueLabel.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(10)
                make.centerY.equalToSuperview()
            }
        }
        
        if !isLast {
            separatorView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(10)
                make.bottom.equalToSuperview()
            }
        }
    }
    
    func setupBindings() {
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellTapped)))
    }
}

// MARK: - Private methods

private extension ProfileDetailCell {
    func setup(_ vm: ProfileDetailCellViewModel) {
        titleLabel.text = vm.title
        valueLabel.text = vm.value
    }
}

// MARK: - Actions

private extension ProfileDetailCell {
    @objc func cellTapped() {
        if let type = viewModel?.detail.type {
            didProfileDetailCellTap?(type)
        }
    }
}
