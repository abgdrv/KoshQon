//
//  SeparatorView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 04.03.2024.
//

import UIKit
import SnapKit

final class SeparatorView: UIView {
    
    // MARK: - Properties
    
    private let color: UIColor?

    // MARK: - UI
    
    private lazy var lineView = UIView().apply { $0.backgroundColor = color }
    
    // MARK: - Object Lifecycle
    
    init(color: UIColor? = nil) {
        self.color = color ?? AppColor.Static.lightGray.uiColor
        super.init(frame: .zero)
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
        addSubview(lineView)
    }
    
    func setupConstraints() {
        lineView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
