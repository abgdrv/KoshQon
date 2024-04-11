//
//  FriendCell.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 10.04.2024.
//

import UIKit
import SnapKit

final class FriendCell: BaseCell {

    // MARK: - Properties
    
    var didFriendCellTap: Callback<Int>?
    var didMoreButtonTap: Callback<Int>?
    
    private let viewModel: FriendCellViewModel
    
    // MARK: - UI
    
    private lazy var profileImageView = ProfileImageView(image: nil, isEditable: false)
    private lazy var containerView = UIView()
    
    private lazy var fullNameLabel = UILabel().apply {
        $0.set(font: AppFont.medium.s16, textColor: AppColor.Theme.mainTitle.uiColor)
    }
    
    private lazy var locationLabel = UILabel().apply {
        $0.set(font: AppFont.medium.s12, textColor: AppColor.Static.darkGray.uiColor)
    }
    
    private lazy var moreButton = UIButton(type: .custom).apply {
        $0.setImage(AppImage.Common.more.uiImage, for: .normal)
        $0.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    private lazy var separatorView = SeparatorView()
    
    // MARK: - Object Lifecycle
    
    init(viewModel: FriendCellViewModel) {
        self.viewModel = viewModel
        super.init()
        setupViews()
        setupConstraints()
        setupBindings()
        setup(viewModel)
    }
}

// MARK: - Setup Views

private extension FriendCell {
    func setupViews() {
        backgroundColor = .clear
        contentView.addSubviews(profileImageView, containerView)
        containerView.addSubviews(fullNameLabel, locationLabel, moreButton, separatorView)
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(50)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        fullNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.leading.equalToSuperview()
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(fullNameLabel.snp.bottom)
            make.leading.equalToSuperview()
        }
        
        moreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupBindings() {
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellTapped)))
    }
}

// MARK: - Private methods

private extension FriendCell {
    func setup(_ vm: FriendCellViewModel) {
        fullNameLabel.text = "\(vm.firstName) \(vm.lastName)"
        locationLabel.text = "\(vm.city), \(vm.country)"
    }
}

// MARK: - Actions

private extension FriendCell {
    @objc func cellTapped() {
        didFriendCellTap?(viewModel.friend.id)
    }
    
    @objc func moreButtonTapped() {
        didMoreButtonTap?(viewModel.friend.id)
    }
}
