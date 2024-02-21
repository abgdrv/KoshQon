//
//  InputLabel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.02.2024.
//

import UIKit

final class InputLabel: UILabel {
    
    // MARK: - Object Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        font = AppFont.regular.s16
        textColor = AppColor.darkGray.uiColor
        textAlignment = .natural
    }
}
