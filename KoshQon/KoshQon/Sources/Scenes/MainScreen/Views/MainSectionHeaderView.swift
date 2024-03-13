//
//  MainSectionHeaderView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 10.03.2024.
//

import UIKit
import SnapKit

final class MainSectionHeaderView: UIView {

    // MARK: - UI
    
    private lazy var titleLabel = UILabel().apply {
        $0.set(font: AppFont.regular.s20, textColor: AppColor.Theme.mainTitle.uiColor)
        $0.text = "Последние объявления"
    }
    
    // MARK: - Object Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views

private extension MainSectionHeaderView {
    func setupViews() {
        backgroundColor = AppColor.Theme.secondaryBackground.uiColor
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.bottom.equalToSuperview()
        }
    }
}
