//
//  SplashScreenViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.02.2024.
//

import UIKit
import SwiftUI
import SnapKit

final class SplashScreenViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var hostingController = UIHostingController(rootView: SplashScreenView())
    private lazy var splashScreenView = hostingController.view ?? UIView()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

// MARK: - Setup Views, Constraints

private extension SplashScreenViewController {
    
    func setupViews() {
        view.backgroundColor = AppColor.mainBackground.uiColor
        view.addSubview(splashScreenView)
    }
        
    func setupConstraints() {
        splashScreenView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
