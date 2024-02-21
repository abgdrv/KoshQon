//
//  ProceedButton.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.02.2024.
//

import UIKit

final class ProceedButton: UIButton {
    
    // MARK: - View Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = AppColor.orange.uiColor
        setTitleColor(AppColor.white.uiColor, for: .normal)
    }
}
