//
//  NavigationCell.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 04.03.2024.
//

import UIKit
import SnapKit

final class NavigationCell: UITableViewCell {

    // MARK: - Properties
    
    private var viewModel: NavigationCellViewModel? {
        didSet {
            if let vm = viewModel {
                setup(vm)
            }
        }
    }
    
    private var isLast = false
        
    // MARK: - UI
    
    private lazy var iconImageView = UIImageView().apply { $0.contentMode = .scaleAspectFit }
    private lazy var containerView = UIView()
    
    private lazy var titleLabel = UILabel().apply {
        $0.set(font: AppFont.regular.s16, textColor: AppColor.Theme.mainTitle.uiColor)
    }
    
    private lazy var separatorView = SeparatorView()
    
    private lazy var expandRightIconImageView = UIImageView().apply {
        $0.image = AppImage.Common.expandRight.uiImage
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: - Object Lifecycle

    init(viewModel: NavigationCellViewModel) {
        super.init(style: .default, reuseIdentifier: NavigationCell.reuseID)
        defer {
            self.viewModel = viewModel
            setupViews()
            setupConstraints()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        titleLabel.text = nil
    }
}

// MARK: - Setup Views

private extension NavigationCell {
    func setupViews() {
        backgroundColor = AppColor.Theme.mainBackground.uiColor
        contentView.addSubviews(iconImageView, containerView)
        containerView.addSubviews(titleLabel, expandRightIconImageView)
        if !isLast {
            containerView.addSubview(separatorView)
        }
    }
    
    func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
            make.trailing.height.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        if !isLast {
            separatorView.snp.makeConstraints { make in
                make.bottom.width.equalToSuperview()
            }
        }
        
        expandRightIconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
}

// MARK: - Private methods

private extension NavigationCell {
    func setup(_ vm: NavigationCellViewModel) {
        titleLabel.text = vm.title
        iconImageView.image = vm.image
        isLast = vm.isLast
    }
}
