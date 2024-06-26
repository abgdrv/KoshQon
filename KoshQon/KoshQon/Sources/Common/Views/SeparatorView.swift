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
    
    private lazy var lineView = UIView().apply { $0.backgroundColor = AppColor.Theme.separation.uiColor }
    
    // MARK: - Object Lifecycle
    
    init() {
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
        lineView.layer.cornerRadius = lineView.frame.height / 2
    }
}

// MARK: - Setup Views

private extension SeparatorView {
    func setupViews() {
        addSubview(lineView)
    }
    
    func setupConstraints() {
        lineView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
