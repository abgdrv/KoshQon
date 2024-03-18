//
//  ProfileCharacteristicProgressView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 17.03.2024.
//

import UIKit
import SnapKit

final class ProfileCharacteristicProgressView: UIView {

    // MARK: - Properties
    
    private let type: CharacteristicType
    private let progress: Float
    
    // MARK: - UI
    
    private lazy var contentView = UIView()
    
    private lazy var iconImageView = UIImageView(image: type.image).apply {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var titleLabel = UILabel().apply {
        $0.set(font: AppFont.medium.s10, textColor: AppColor.Theme.mainTitle.uiColor)
        $0.text = type.title
    }
    
    private lazy var progressView = UIProgressView().apply {
        $0.progress = progress / 10
        $0.progressTintColor = type.color
    }
    
    private lazy var progressLabel = UILabel().apply {
        $0.set(font: AppFont.medium.s10, textColor: AppColor.Theme.mainTitle.uiColor)
        $0.text = "\(progress)"
    }
    
    // MARK: - Object Lifecycle
    
    init(type: CharacteristicType, progress: Float) {
        self.type = type
        self.progress = progress
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views

private extension ProfileCharacteristicProgressView {
    func setupViews() {
        addSubview(contentView)
        contentView.addSubviews(iconImageView, titleLabel, progressView, progressLabel)
    }
    
    func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(24)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.size.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalTo(iconImageView.snp.trailing).offset(4)
        }
        
        progressView.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(4)
            make.trailing.bottom.equalToSuperview()
        }
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.trailing.equalToSuperview()
        }
    }
}
