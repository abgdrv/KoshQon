//
//  ProfileCharacteristicView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 18.03.2024.
//

import UIKit
import SnapKit

final class ProfileCharacteristicView: UIView {

    // MARK: - Properties
    
    private let type: CharacteristicType
    private let isEnabled: Bool
    
    // MARK: - UI
    
    private lazy var iconImageView = UIImageView(image: type.image).apply {
        $0.contentMode = .scaleAspectFit
        $0.alpha = isEnabled ? 1.0 : 0.3
    }
    
    private lazy var titleLabel = UILabel().apply {
        $0.set(font: AppFont.medium.s12, textColor: AppColor.Static.orange.uiColor)
        $0.text = type.title
        $0.alpha = isEnabled ? 1.0 : 0.3
    }
    
    // MARK: - Object Lifecycle
    
    init(type: CharacteristicType, isEnabled: Bool) {
        self.type = type
        self.isEnabled = isEnabled
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views

private extension ProfileCharacteristicView {
    func setupViews() {
        addSubviews(iconImageView, titleLabel)
    }
    
    func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.size.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(4)
            make.top.bottom.equalToSuperview()
        }
    }
}
