//
//  BaseView.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 23.02.2024.
//

import UIKit
import SnapKit

class BaseView: UIView {
    
    // MARK: - Properties
    
    var keyboardHandlingButton: ProceedButton? {
        return nil
    }
    
    // MARK: - Object Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupGestures()
        setupObservers()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented!")
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
    
    func setupObservers() {
        if !UIDevice.current.isSmall {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                                   name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                                   name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
}

// MARK: - Actions

private extension BaseView {
    @objc func viewTapped() {
        endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height + 8
            keyboardHandlingButton?.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().inset(keyboardHeight)
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(50)
            }
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        keyboardHandlingButton?.snp.remakeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}
