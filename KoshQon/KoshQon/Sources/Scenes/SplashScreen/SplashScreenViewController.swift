//
//  SplashScreenViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.02.2024.
//

import UIKit
import SwiftUI
import SnapKit

class SplashScreenViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var splashScreenView = SplashScreenView()
    private lazy var hostingController = UIHostingController(rootView: splashScreenView)
    private lazy var splashScreen = hostingController.view ?? UIView()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = AppColor.mainBackground.uiColor
        view.addSubview(splashScreen)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        splashScreen.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
