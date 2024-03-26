//
//  AddAnnouncementView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.03.2024.
//

import UIKit
import SnapKit

final class AddAnnouncementView: BaseView {

    // MARK: - Properties
    
    // MARK: - UI
    
    private lazy var mainTitleLabel = UILabel().apply {
        $0.text = "Подать"
        $0.set(font: AppFont.medium.s24, textColor: AppColor.Theme.mainTitle.uiColor)
    }
    
    private lazy var newAnnouncementTitleLabel = UILabel().apply {
        $0.text = "Новое объявление"
        $0.set(font: AppFont.medium.s16, textColor: AppColor.Theme.mainTitle.uiColor)
    }
    
    // MARK: - Object Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
}

// MARK: - Setup Views

private extension AddAnnouncementView {
    func setupViews() {
        addSubviews(mainTitleLabel, newAnnouncementTitleLabel)
    }
    
    func setupConstraints() {
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
        }
        
        newAnnouncementTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
        }
    }
}
