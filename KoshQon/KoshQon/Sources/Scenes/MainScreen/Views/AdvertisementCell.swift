//
//  AdvertisementCell.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 09.03.2024.
//

import UIKit
import SnapKit

final class AdvertisementCell: UITableViewCell {
    
    // MARK: - Properties
    
    // MARK: - UI
    
    private lazy var containerView = UIView().apply {
        $0.backgroundColor = AppColor.Theme.mainBackground.uiColor
    }
    
    private lazy var adImageView = UIImageView(image: AppImage.Main.adBlank.uiImage).apply {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    private lazy var titleLabel = UILabel().apply {
        $0.set(font: AppFont.regular.s16, textColor: AppColor.Theme.mainTitle.uiColor)
        $0.numberOfLines = 0
    }
    
    private lazy var addressLabel = UILabel().apply {
        $0.set(font: AppFont.regular.s12, textColor: AppColor.Static.darkGray.uiColor)
        $0.textAlignment = .right
    }
    
    private lazy var separatorView = SeparatorView()
    
    private lazy var bottomContainerView = UIView()
    
    private lazy var dateLabel = UILabel().apply {
        $0.set(font: AppFont.regular.s12, textColor: AppColor.Static.darkGray.uiColor)
    }
    
    private lazy var ratingImageView = UIImageView(image: AppImage.Main.star.uiImage).apply {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var ratingLabel = UILabel().apply {
        $0.set(font: AppFont.regular.s12, textColor: AppColor.Static.yellow.uiColor)
    }
    
    // MARK: - Object Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        adImageView.layer.cornerRadius = 10
    }
    
    // MARK: - Override methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        adImageView.image = nil
        titleLabel.text = nil
        addressLabel.text = nil
        dateLabel.text = nil
        ratingLabel.text = nil
    }
}

// MARK: - Setup Views

private extension AdvertisementCell {
    func setupViews() {
        backgroundColor = AppColor.Theme.secondaryBackground.uiColor
        contentView.addSubview(containerView)
        containerView.addSubviews(adImageView, titleLabel, addressLabel, separatorView, bottomContainerView)
        bottomContainerView.addSubviews(dateLabel, ratingImageView, ratingLabel)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        adImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(8)
            make.size.equalTo(150)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(adImageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.leading.equalTo(adImageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalTo(adImageView.snp.bottom)
        }
        
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.equalTo(adImageView.snp.bottom).offset(10)
        }
        
        bottomContainerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.equalTo(separatorView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        ratingImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.trailing.equalTo(ratingLabel.snp.leading).offset(-5)
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
}

extension AdvertisementCell {
    func configure(ad: Advertisement) {
        titleLabel.text = ad.title
        dateLabel.text = ad.date
        addressLabel.text = ad.address
        ratingLabel.text = ad.rating
    }
}
