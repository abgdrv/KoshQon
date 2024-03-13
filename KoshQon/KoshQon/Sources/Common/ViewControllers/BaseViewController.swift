//
//  BaseViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 26.02.2024.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
}

// MARK: - Navigation

private extension BaseViewController {
    func setupNavigation() {
        let backButtonImage = AppImage.Common.backArrow.uiImage?.withRenderingMode(.alwaysTemplate)
        let backButton = UIBarButtonItem(image: backButtonImage,
                                         style: .plain, target: self, action: #selector(backButtonTapped))
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.tintColor = AppColor.Theme.mainTitle.uiColor
        if navigationController.viewControllers.count != 1 {
            navigationItem.leftBarButtonItem = backButton
        }
        navigationController.interactivePopGestureRecognizer?.delegate = self
        navigationController.navigationBar.backgroundColor = AppColor.Theme.mainBackground.uiColor
    }
}

private extension BaseViewController {
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
