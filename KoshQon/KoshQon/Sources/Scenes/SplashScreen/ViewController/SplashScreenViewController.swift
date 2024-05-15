//
//  SplashScreenViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.02.2024.
//

import SwiftUI
import SnapKit

final class SplashScreenViewController: BaseViewController {
    
    // MARK: - Properties
    
    var didFinish: VoidCallback?
    
    private let animationDelay = 1.8
    
    // MARK: - UI
    
    private lazy var hostingController = UIHostingController(rootView: SplashScreenView())
    private lazy var splashScreenView = hostingController.view ?? UIView()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDelay) {
            self.didFinish?()
        }
    }
}

// MARK: - Setup Views

private extension SplashScreenViewController {
    func setupViews() {
        view.addSubview(splashScreenView)
    }
        
    func setupConstraints() {
        splashScreenView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
