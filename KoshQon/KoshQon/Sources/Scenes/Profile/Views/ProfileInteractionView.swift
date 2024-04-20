//
//  ProfileInteractionView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 11.04.2024.
//

import UIKit
import SnapKit

final class ProfileInteractionView: UIView {

    // MARK: - Properties
    
    private let isFriend: Bool
    
    // MARK: - UI
    
    private lazy var writeButton = ActionButton(type: .system).apply {
        $0.type = .write
        $0.addTarget(self, action: #selector(writeButtonTapped), for: .touchUpInside)
    }
    
    private lazy var actionFriendButton = ActionButton(type: .system).apply {
        $0.type = .friend
        $0.addTarget(self, action: #selector(actionFriendButtonTapped), for: .touchUpInside)
    }
    
    private lazy var moreButton = UIButton(type: .custom).apply {
        $0.setImage(AppImage.Common.more.uiImage, for: .normal)
        $0.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Object Lifecycle
    
    init(isFriend: Bool) {
        self.isFriend = isFriend
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
}

// MARK: - Setup Views

private extension ProfileInteractionView {
    func setupViews() {
        
    }
    
    func setupConstraints() {
        
    }
}

// MARK: - Actions

private extension ProfileInteractionView {
    @objc func writeButtonTapped() {
        
    }
    
    @objc func actionFriendButtonTapped() {
        
    }
    
    @objc func moreButtonTapped() {
        
    }
}
