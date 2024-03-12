//
//  MainScreenViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.03.2024.
//

import UIKit

final class MainScreenViewController: BaseViewController {
    
    // MARK: - Properties
    
    // TODO: VM
    
    // MARK: - UI
    
    private lazy var mainScreenView = MainScreenView()
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = mainScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
}

// MARK: - Setup

private extension MainScreenViewController {
    func setupNavigation() {
        navigationItem.titleView = NavigationTitleView(type: .koshqon)
    }
}
