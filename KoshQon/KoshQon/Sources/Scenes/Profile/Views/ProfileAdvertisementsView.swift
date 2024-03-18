//
//  ProfileAdvertisementsView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 18.03.2024.
//

import UIKit
import SnapKit

final class ProfileAdvertisementsView: UIView {
        
    // MARK: - Properties
    
    private var advertisements: [AdvertisementViewModel]
    
    // MARK: - UI
    
    private lazy var containerView = UIView().apply {
        $0.backgroundColor = AppColor.Theme.mainBackground.uiColor
    }
    
    private lazy var advertisementsTitleLabel = UILabel().apply {
        $0.set(font: AppFont.medium.s20, textColor: AppColor.Theme.mainTitle.uiColor)
        $0.text = "Объявления"
    }
    
    private lazy var advertisementsStackView = UIStackView(arrangedSubviews: getAdvertisements()).apply {
        $0.axis = .vertical
    }
    
    // MARK: - Object Lifecycle
    
    init(advertisements: [AdvertisementViewModel]) {
        self.advertisements = advertisements
        super.init(frame: .zero)
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

private extension ProfileAdvertisementsView {
    func setupViews() {
        addSubview(containerView)
        containerView.addSubviews(advertisementsTitleLabel, advertisementsStackView)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        advertisementsTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
        }
        
        advertisementsStackView.snp.makeConstraints { make in
            make.top.equalTo(advertisementsTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
    }
}

// MARK: - Private methods

private extension ProfileAdvertisementsView {
    func getAdvertisements() -> [AdvertisementView] {
        var views: [AdvertisementView] = []
        advertisements.forEach {
            let view = AdvertisementView(viewModel: $0)
            views.append(view)
        }
        return views
    }
}
