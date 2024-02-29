//
//  BaseView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 23.02.2024.
//

import UIKit

class BaseView: UIView {
    
    // MARK: - Object Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Setup Views, Gestures

private extension BaseView {
    func setupViews() {
        backgroundColor = AppColor.Theme.mainBackground.uiColor
    }
    
    func setupGestures() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
    }
}

// MARK: - Actions

private extension BaseView {
    @objc func viewTapped() {
        endEditing(true)
    }
}
