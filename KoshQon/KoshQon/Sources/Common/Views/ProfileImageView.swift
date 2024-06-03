//
//  ProfileImageView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import UIKit
import SnapKit

final class ProfileImageView: UIView {
    
    // MARK: - Properties
    
    var didImageTap: VoidCallback?
    
    var image: UIImage? {
        didSet {
            profileImageView.image = image
        }
    }
    
    private let isEditable: Bool
    
    // MARK: - UI
    
    private lazy var profileImageView = UIImageView(image: image).apply {
        $0.isUserInteractionEnabled = true
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    private lazy var plusImageView = UIImageView(image: AppImage.Personal.plus.uiImage)
    
    // MARK: - Object Lifecycle
    
    init(image: UIImage? = nil, isEditable: Bool) {
        self.image = image ?? AppImage.Personal.defaultProfile.uiImage
        self.isEditable = isEditable
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        if isEditable {
            plusImageView.layer.cornerRadius = plusImageView.frame.height / 2
            plusImageView.bezierPathBorder(color: AppColor.Theme.mainBackground.uiColor, width: 5)
        }
    }
}

// MARK: - Setup Views

private extension ProfileImageView {
    func setupViews() {
        isEditable ? addSubviews(profileImageView, plusImageView) : addSubview(profileImageView)
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        if isEditable {
            plusImageView.snp.makeConstraints { make in
                make.trailing.equalTo(profileImageView.snp.trailing)
                make.bottom.equalTo(profileImageView.snp.bottom)
                make.size.equalTo(32)
            }
        }
    }
    
    func setupBindings() {
        if isEditable {
            profileImageView.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
            )
        }
    }
}

// MARK: - Actions

private extension ProfileImageView {
    @objc func profileImageTapped() {
        didImageTap?()
    }
}
