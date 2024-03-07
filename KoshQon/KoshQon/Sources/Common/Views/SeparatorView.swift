//
//  SeparatorView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 04.03.2024.
//

import UIKit
import SnapKit

final class SeparatorView: UIView {

    // MARK: - UI
    
    private lazy var lineView = UIView().apply {
        $0.backgroundColor = AppColor.Static.lightGray.uiColor
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

private extension SeparatorView {
    func setupViews() {
        addSubviews(lineView)
    }
    
    func setupConstraints() {
        lineView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
