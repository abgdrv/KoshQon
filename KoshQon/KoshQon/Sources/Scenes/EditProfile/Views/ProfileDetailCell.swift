//
//  ProfileDetailCell.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 28.03.2024.
//

import UIKit
import SnapKit

final class ProfileDetailCell: BaseCell {

    // MARK: - Properties
    
    var didProfileDetailCellTap: Callback<ProfileDetailCellViewModel>?
    
    private let viewModel: ProfileDetailCellViewModel
    
    private let isEditable: Bool
    private let isLast: Bool
    private let type: ProfileDetailType
    
    private var value: String? {
        didSet {
            valueLabel.text = value
            viewModel.detail.value = value ?? ""
        }
    }
    
    // MARK: - UI
    
    private lazy var titleLabel = UILabel().apply {
        $0.set(font: AppFont.medium.s16, textColor: AppColor.Theme.mainTitle.uiColor)
    }
    
    private lazy var valueLabel = UILabel().apply {
        $0.set(font: AppFont.regular.s16, textColor: AppColor.Static.darkGray.uiColor)
    }
    
    private lazy var expandRightIconImageView = UIImageView(image: AppImage.Common.expandRight.uiImage).apply {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var menuButton = MenuButton(type: .system).apply { $0.menuType = type.menuType }
    private lazy var dateTextField = InputTextField(inputType: .detailDate).apply { $0.inputView = datePicker }
    private lazy var datePicker = DatePicker(format: "dd.MM.yyyy")
    private lazy var separatorView = SeparatorView()
    
    // MARK: - Object Lifecycle
    
    init(viewModel: ProfileDetailCellViewModel) {
        self.viewModel = viewModel
        self.isEditable = viewModel.isEditable
        self.isLast = viewModel.isLast
        self.type = viewModel.detail.type
        super.init()
        setupViews()
        setupConstraints()
        setupBindings()
        setup(viewModel)
    }
}

// MARK: - Setup Views

private extension ProfileDetailCell {
    func setupViews() {
        backgroundColor = AppColor.Theme.blockBackground.uiColor
        contentView.addSubviews(titleLabel, valueLabel)
        
        if isEditable {
            contentView.addSubview(expandRightIconImageView)
        }
        
        if !isLast {
            contentView.addSubview(separatorView)
        }
        
        if type.menuType != nil {
            contentView.addSubview(menuButton)
        }
        
        if type == .birthday {
            contentView.addSubview(dateTextField)
        }
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        if isEditable {
            expandRightIconImageView.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(5)
                make.centerY.equalToSuperview()
                make.size.equalTo(24)
            }
            
            valueLabel.snp.makeConstraints { make in
                make.leading.equalTo(titleLabel.snp.trailing).offset(10)
                make.trailing.equalTo(expandRightIconImageView.snp.leading).offset(-5)
                make.centerY.equalToSuperview()
            }
        } else {
            valueLabel.snp.makeConstraints { make in
                make.leading.equalTo(titleLabel.snp.trailing).offset(10)
                make.trailing.equalToSuperview().inset(10)
                make.centerY.equalToSuperview()
            }
        }
        
        if !isLast {
            separatorView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(10)
                make.bottom.equalToSuperview()
            }
        }
        
        if type.menuType != nil {
            menuButton.snp.makeConstraints { make in
                make.leading.equalTo(titleLabel.snp.trailing).offset(10)
                make.trailing.top.bottom.equalToSuperview()
            }
        }
    }
    
    func setupBindings() {
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellTapped)))
        
        menuButton.didSelect = { [weak self] value in
            guard let self = self else { return }
            self.value = value
        }
        
        datePicker.didDateChange = { [weak self] selectedDate in
            guard let self = self else { return }
            self.value = selectedDate
        }
    }
}

// MARK: - Private methods

private extension ProfileDetailCell {
    func setup(_ vm: ProfileDetailCellViewModel) {
        titleLabel.text = vm.title
        valueLabel.text = vm.value
        datePicker.date = vm.detail.value.toDate(format: "dd.MM.yyyy") ?? Date()
    }
}

// MARK: - Actions

private extension ProfileDetailCell {
    @objc func cellTapped() {
        if type == .birthday {
            dateTextField.becomeFirstResponder()
        }
    }
}
