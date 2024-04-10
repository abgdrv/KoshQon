//
//  ProfileTopView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 15.03.2024.
//

import UIKit
import SnapKit

final class ProfileTopView: UIView {

    // MARK: - Properties
    
    var didFriendsTap: VoidCallback?
    
    private let info: ProfileMainInfo?
    
    // MARK: - UI
    
    private lazy var profileImageView = ProfileImageView(image: nil, isEditable: false)
    
    private lazy var nameLabel = UILabel().apply {
        $0.set(font: AppFont.medium.s20, textColor: AppColor.Theme.mainTitle.uiColor)
        $0.text = info?.fullName
    }
    
    private lazy var locationLabel = UILabel().apply {
        $0.set(font: AppFont.medium.s12, textColor: AppColor.Static.darkGray.uiColor)
        $0.text = info?.location
    }
    
    private lazy var ageLabel = UILabel().apply {
        $0.set(font: AppFont.medium.s12, textColor: AppColor.Static.darkGray.uiColor)
        $0.text = "\(info?.age ?? 0) лет"
    }
    
    private lazy var friendsButton = UIButton(type: .system).apply {
        $0.setTitleColor(AppColor.Static.orange.uiColor, for: .normal)
        $0.setTitle("\(info?.friends ?? 0) друзей", for: .normal)
        $0.addTarget(self, action: #selector(friendsButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Object Lifecycle
    
    init(info: ProfileMainInfo?) {
        self.info = info
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views

private extension ProfileTopView {
    func setupViews() {
        backgroundColor = AppColor.Theme.mainBackground.uiColor
        addSubviews(profileImageView, nameLabel, locationLabel, ageLabel, friendsButton)
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().offset(16)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(2)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        friendsButton.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.bottom.equalTo(profileImageView.snp.bottom)
        }
    }
}

// MARK: - Actions

private extension ProfileTopView {
    @objc func friendsButtonTapped() {
        didFriendsTap?()
    }
}
