//
//  MainScreenViewController.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 01.03.2024.
//

import UIKit

final class MainScreenViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let viewModel: MainScreenViewModel
    
    // TODO: VM
    
    // MARK: - UI
    
    private lazy var mainScreenView = MainScreenView(viewModel: viewModel)
    
    // MARK: - Object Lifecycle
    
    init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        navigationItem.titleView = NavigationTitleView(type: .main)
    }
}
