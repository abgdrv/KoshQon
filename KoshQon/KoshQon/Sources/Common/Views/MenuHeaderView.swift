//
//  MenuHeaderView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 03.04.2024.
//

import UIKit
import SnapKit

final class MenuHeaderView: UIView {

    // MARK: - Properties
    
    private let menuType: MenuType
    
    // MARK: - UI
    
    private lazy var titleLabel = UILabel().apply {
        $0.set(font: AppFont.semibold.s16, textColor: AppColor.Theme.mainTitle.uiColor)
        $0.text = menuType.title
    }
    
    private lazy var separatorView = SeparatorView()
    
    // MARK: - Object Lifecycle
    
    init(menuType: MenuType) {
        self.menuType = menuType
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views

private extension MenuHeaderView {
    func setupViews() {
        backgroundColor = AppColor.Theme.menuBackground.uiColor
        addSubviews(titleLabel, separatorView)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.bottom.width.equalToSuperview()
        }
    }
}
