//
//  BottomSheetCell.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.03.2024.
//

import UIKit
import SnapKit

final class BottomSheetCell: UITableViewCell {
    
    // MARK: - Properties
        
    private var primeText: String = ""
    private var secondText: String? = ""
    private var optionText: String {
        return (secondText ?? "") + primeText
    }
    
    // MARK: - UI
    
    private lazy var optionLabel = UILabel().apply {
        $0.font = AppFont.medium.s16
        $0.textColor = AppColor.Static.black.uiColor
        $0.text = optionText
    }
        
    private lazy var separatorView = SeparatorView()

    // MARK: - Object Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}

// MARK: - Setup Views

private extension BottomSheetCell {
    func setupViews() {
        contentView.addSubviews(optionLabel, separatorView)
    }
    
    func setupConstraints() {
        optionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}

// MARK: - Public methods

extension BottomSheetCell {
    func configure(option: BottomSheetOption) {
        primeText = option.primeText
        secondText = option.secondText
        optionLabel.text = optionText
    }
}

