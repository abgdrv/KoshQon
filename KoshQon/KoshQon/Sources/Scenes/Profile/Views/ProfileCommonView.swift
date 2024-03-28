//
//  ProfileCommonView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 15.03.2024.
//

import UIKit
import SnapKit

final class ProfileCommonView: UIView {

    // MARK: - Properties
    
    private let info: ProfileCommonInfo?
    private var characteristicsViews: [UIView] = []
    
    // MARK: - UI
    
    private lazy var containerView = UIView().apply {
        $0.backgroundColor = AppColor.Theme.blockBackground.uiColor
    }
    
    private lazy var contentView = UIView()
    
    private lazy var commonTitleLabel = UILabel().apply {
        $0.set(font: AppFont.medium.s20, textColor: AppColor.Theme.mainTitle.uiColor)
        $0.text = "Общие сведения"
    }
    
    private lazy var ratingTitleLabel = UILabel().apply {
        $0.set(font: AppFont.medium.s14, textColor: AppColor.Theme.mainTitle.uiColor)
        $0.text = "Рейтинг"
    }
    
    private lazy var ratingLabel = UILabel().apply {
        $0.set(font: AppFont.medium.s40, textColor: AppColor.Theme.mainTitle.uiColor)
        $0.text = "\(info?.rating ?? 0)"
    }
    
    private lazy var starImageView = UIImageView(image: AppImage.Common.star.uiImage).apply {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var mainCharView = UIStackView(arrangedSubviews: Array(characteristicsViews[0..<3])).apply {
        $0.axis = .vertical
    }
    
    private lazy var bottomCharView = UIView()
    
    private lazy var leftCharView = UIStackView(arrangedSubviews: Array(characteristicsViews[3..<7])).apply {
        $0.axis = .vertical
        $0.spacing = 2
    }
    
    private lazy var rightCharView = UIStackView(arrangedSubviews: Array(characteristicsViews[7..<11])).apply {
        $0.axis = .vertical
        $0.spacing = 2
    }
    
    // MARK: - Object Lifecycle
    
    init(info: ProfileCommonInfo?) {
        self.info = info
        super.init(frame: .zero)
        self.characteristicsViews = getCharacteristicViews(enabledChars: info?.characteristics ?? [])
        setupViews()
        setupConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 10
    }
}

// MARK: - Setup Views

private extension ProfileCommonView {
    func setupViews() {
        addSubview(containerView)
        containerView.addSubview(contentView)
        contentView.addSubviews(commonTitleLabel, ratingTitleLabel, ratingLabel, starImageView,
                                mainCharView, bottomCharView)
        bottomCharView.addSubviews(leftCharView, rightCharView)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        commonTitleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
        
        ratingTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(commonTitleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingTitleLabel.snp.bottom)
            make.leading.equalToSuperview()
        }
        
        starImageView.snp.makeConstraints { make in
            make.leading.equalTo(ratingLabel.snp.trailing).offset(6)
            make.size.equalTo(32)
            make.centerY.equalTo(ratingLabel.snp.centerY)
        }
        
        mainCharView.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        bottomCharView.snp.makeConstraints { make in
            make.top.equalTo(mainCharView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
        
        leftCharView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(8)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        rightCharView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(8)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
    }
}

// MARK: - Private methods

private extension ProfileCommonView {
    func getCharacteristicViews(enabledChars: [CharacteristicType]) -> [UIView] {
        var views: [UIView] = []
        
        for caseValue in CharacteristicType.allCases {
            let view: UIView
            switch caseValue {
            case .good:
                view = ProfileCharacteristicProgressView(type: caseValue, progress: info?.good ?? 0)
            case .responsible:
                view = ProfileCharacteristicProgressView(type: caseValue, progress: info?.responsible ?? 0)
            case .clean:
                view = ProfileCharacteristicProgressView(type: caseValue, progress: info?.clean ?? 0)
            default:
                view = ProfileCharacteristicView(type: caseValue, isEnabled: enabledChars.contains(caseValue))
            }
            views.append(view)
        }
        
        return views
    }
}
