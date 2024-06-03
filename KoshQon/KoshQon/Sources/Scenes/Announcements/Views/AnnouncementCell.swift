//
//  AnnouncementCell.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 09.03.2024.
//

import UIKit
import SnapKit
import UIView_Shimmer

final class AnnouncementCell: BaseCell, ShimmeringViewProtocol {
    
    // MARK: - Properties
    
    var didAnnouncementCellTap: Callback<Announcement>?
    
    private let viewModel: AnnouncementViewModel
    
    var shimmeringAnimatedItems: [UIView] {
        [
            adImageView,
            titleLabel,
            addressLabel,
            ageLabel,
            genderLabel,
            budgetLabel,
            dateLabel
        ]
    }
    
    // MARK: - UI
    
    private lazy var containerView = UIView().apply {
        $0.backgroundColor = AppColor.Theme.blockBackground.uiColor
    }
    
    private lazy var adImageView = UIImageView(image: AppImage.Main.adBlank.uiImage).apply {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private lazy var titleLabel = UILabel().apply {
        $0.set(font: AppFont.regular.s16, textColor: AppColor.Theme.mainTitle.uiColor)
        $0.numberOfLines = 0
        $0.text = "                                                                                       "
    }
    
    private lazy var addressLabel = UILabel().apply {
        $0.set(font: AppFont.regular.s12, textColor: AppColor.Static.darkGray.uiColor)
        $0.textAlignment = .right
        $0.text = "                                                                                       "
    }
    
    private lazy var ageLabel = UILabel().apply {
        $0.set(font: AppFont.regular.s12, textColor: AppColor.Static.darkGray.uiColor)
        $0.text = "                                                                                       "
    }
    
    private lazy var genderLabel = UILabel().apply {
        $0.set(font: AppFont.regular.s12, textColor: AppColor.Static.darkGray.uiColor)
        $0.text = "                                                                                       "
    }
    
    private lazy var budgetLabel = UILabel().apply {
        $0.set(font: AppFont.regular.s12, textColor: AppColor.Static.darkGray.uiColor)
        $0.text = "                                                                                       "
    }
    
    private lazy var separatorView = SeparatorView()
    
    private lazy var bottomContainerView = UIView()
    
    private lazy var dateLabel = UILabel().apply {
        $0.set(font: AppFont.regular.s12, textColor: AppColor.Static.darkGray.uiColor)
        $0.text = "                                                                                       "
    }
    
    
    // MARK: - Object Lifecycle
    
    init(viewModel: AnnouncementViewModel, isGradient: Bool) {
        self.viewModel = viewModel
        super.init()
        setupViews()
        setupConstraints()
        setupBindings()
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.setup(viewModel)
        }
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.backgroundColor = viewModel.isProfile
                                ? AppColor.Theme.blockBackground.cgColor
                                : AppColor.Theme.secondaryBackground.cgColor
        containerView.layer.cornerRadius = 10
        adImageView.layer.cornerRadius = 10
    }
    
    // MARK: - Override methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stopSkeleton()
        adImageView.image = nil
        titleLabel.text = nil
        addressLabel.text = nil
        dateLabel.text = nil
    }
}

// MARK: - Setup Views

private extension AnnouncementCell {
    func setupViews() {
        backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubviews(adImageView, titleLabel, addressLabel, ageLabel, genderLabel, budgetLabel, separatorView, bottomContainerView)
        bottomContainerView.addSubviews(dateLabel)
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
        
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(adImageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(ageLabel.snp.bottom).offset(4)
            make.leading.equalTo(adImageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        budgetLabel.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(4)
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
    }
    
    func setupBindings() {
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellTapped)))
    }
    
    func setupSkeleton() {
//        [titleLabel, ageLabel, genderLabel, budgetLabel, dateLabel, addressLabel, adImageView].forEach {
//            $0.showAnimatedGradientSkeleton()
//        }
//        showske
    }
    
    func stopSkeleton() {
//        adImageView.hideSkeleton()
//        adImageView.layer.cornerRadius = 10
//        titleLabel.hideSkeleton()
//        addressLabel.hideSkeleton()
//        ageLabel.hideSkeleton()
//        genderLabel.hideSkeleton()
//        budgetLabel.hideSkeleton()
//        dateLabel.hideSkeleton()
    }
}

// MARK: - Private methods

private extension AnnouncementCell {
    func setup(_ vm: AnnouncementViewModel) {
        if vm.mainImage != nil {
            adImageView.image = vm.mainImage
        }
        titleLabel.text = vm.title
        dateLabel.text = vm.date
        ageLabel.text = "\(LocalizableKeys.AddAnnouncement.age.localized()): \(vm.age)"
        genderLabel.text = "\(LocalizableKeys.Helpers.gender.localized()): \(vm.gender)"
        budgetLabel.text = "\(LocalizableKeys.AddAnnouncement.budget.localized()): \(vm.budget)"
        addressLabel.text = vm.address
    }
}

// MARK: - Actions

private extension AnnouncementCell {
    @objc func cellTapped() {
        didAnnouncementCellTap?(viewModel.announcement)
    }
}
